//
//  CustomPlugin.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Moya
import UIKit
import SVProgressHUD


public protocol LoadingPluginDelegate{

    /// Represents the authorization header to use for requests.
    var shouldShowLoadingView: Bool? { get }
}
// 自定义插件，控制加载视图的显示与隐藏
public struct LoadingPlugin: PluginType {
    
    
    // 将要发起请求时调用
    public func willSend(_ request: RequestType, target: TargetType) {
        guard let showLoadingView = target as? LoadingPluginDelegate,
            let shouldShowLoadingView = showLoadingView.shouldShowLoadingView
            else { return }
        if shouldShowLoadingView {
            DispatchQueue.main.async {
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setMinimumDismissTimeInterval(2)
                SVProgressHUD.show()

            }
        }
    }
    
    // 请求完成时调用
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss() // 请求完成时隐藏 Toast
            switch result{
            case.success(let response):
                businessHUD(response)
            case .failure(let error):
                if let statusCode = error.response?.statusCode,statusCode == 401{
                    
                    SVProgressHUD.showError(withStatus: "请重新登录~~")

                }else{
                    SVProgressHUD.showError(withStatus: error.errorDescription)

                }
            }
        }
        
    }
    func businessHUD(_  response:Response){
        if let json = try? response.mapJSON() as? [String:[String:Any]]{
            if let retFlag = json["head"]?["retFlag"] as? String{
                if retFlag == "00000"{
//                    let retMsg = json["head"]?["retMsg"] as? String
//                    SVProgressHUD.showSuccess(withStatus: retMsg)
                }else{
                    let retMsg = json["head"]?["retMsg"] as? String
                    SVProgressHUD.showError(withStatus: retMsg)

                }
            }
            
        }else if let json = try? response.mapJSON() as? [String:String]{
            SVProgressHUD.showError(withStatus: json["error_description"])
        }else if let mapString = try? response.mapString(){
            SVProgressHUD.showError(withStatus: mapString)

        }else{
            SVProgressHUD.showError(withStatus: response.description)
        }
    }
}

// MARK: - AccessTokenAuthorizable

/// A protocol for controlling the behavior of `AccessTokenPlugin`.
public protocol HFAccessTokenAuthorizable {

    /// Represents the authorization header to use for requests.
    var authorizationType: HFAuthorizationType? { get }
}

// MARK: - AuthorizationType

/// An enum representing the header to use with an `AccessTokenPlugin`
public enum HFAuthorizationType {

    /// The `"Basic"` header.
    case basic

    /// The `"Bearer"` header.
    case bearer

    /// Custom header implementation.
    case custom(String)

    public var value: String {
        switch self {
        case .basic: return "Basic"
        case .bearer: return "Bearer"
        case .custom(let customValue): return customValue
        }
    }
}

extension HFAuthorizationType: Equatable {
    public static func == (lhs: HFAuthorizationType, rhs: HFAuthorizationType) -> Bool {
        switch (lhs, rhs) {
        case (.basic, .basic),
             (.bearer, .bearer):
            return true

        case let (.custom(value1), .custom(value2)):
            return value1 == value2

        default:
            return false
        }
    }
}

// MARK: - AccessTokenPlugin

/**
 A plugin for adding basic or bearer-type authorization headers to requests. Example:

 ```
 Authorization: Basic <token>
 Authorization: Bearer <token>
 Authorization: <Сustom> <token>
 ```

 */
public struct HFAccessTokenPlugin: PluginType {

    public typealias TokenClosure = (TargetType) -> String

    /// A closure returning the access token to be applied in the header.
    public let tokenClosure: TokenClosure

    /**
     Initialize a new `AccessTokenPlugin`.

     - parameters:
     - tokenClosure: A closure returning the token to be applied in the pattern `Authorization: <AuthorizationType> <token>`
     */
    public init(tokenClosure: @escaping TokenClosure) {
        self.tokenClosure = tokenClosure
    }

    /**
     Prepare a request by adding an authorization header if necessary.

     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {

        guard let authorizable = target as? HFAccessTokenAuthorizable,
              let _ = authorizable.authorizationType
            else { return request }

        var request = request
        let realTarget = (target as? MultiTarget)?.target ?? target
        let authValue = tokenClosure(realTarget)
        request.addValue(authValue, forHTTPHeaderField: "access_token")

        return request
    }
}
