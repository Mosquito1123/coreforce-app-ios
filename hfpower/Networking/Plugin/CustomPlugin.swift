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
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var cachedRequest = request
        
        // 添加缓存逻辑
        if let _ = URLCache.shared.cachedResponse(for: cachedRequest) {
            // 使用缓存的响应
            cachedRequest.cachePolicy = .returnCacheDataElseLoad
        }
        
        return cachedRequest
    }
    
    public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result.flatMap { response -> Result<Response, MoyaError> in
            do {
                // Check if response is successful
                let statusCode = response.statusCode
                guard 200 ..< 300 ~= statusCode else {
                    throw MoyaError.statusCode(response)
                }
                
                // Attempt to map JSON from response
                guard let json = try response.mapJSON() as? [String: Any] else {
                    throw MoyaError.jsonMapping(response)
                }
                
                // Extract the 'retFlag' from 'head' in JSON
                if let head = json["head"] as? [String: Any],
                   let retFlag = head["retFlag"] as? String,
                   retFlag == "00000" {
                    // Here you can manipulate the response or result as needed
                    // For example, modify the result or return a new response
                    // In this example, we return the original response unchanged
                    return .success(response)
                } else {
                    // If 'retFlag' condition is not met, handle the error or modify the result
                    let retMsg = (json["head"] as? [String: Any])?["retMsg"] as? String
                    let errorDescription = retMsg ?? "Invalid retFlag or missing data in JSON response"
                    let userInfo: [String: Any] = [NSLocalizedDescriptionKey: errorDescription]
                    let error = NSError(domain: "com.yourapp.error", code: -1, userInfo: userInfo)
                    throw MoyaError.underlying(error, nil)
                }
            } catch {
                // Handle any errors during processing
                return .failure(MoyaError.underlying(error, response))
            }
        }
    }
    // 将要发起请求时调用
    public func willSend(_ request: RequestType, target: TargetType) {
        if let showLoadingView = target as? LoadingPluginDelegate,
           let shouldShowLoadingView = showLoadingView.shouldShowLoadingView,shouldShowLoadingView {
            DispatchQueue.main.async {
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setMinimumDismissTimeInterval(2)
                SVProgressHUD.show()
                
            }
        }
    }
    
    // 请求完成时调用
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if let showLoadingView = target as? LoadingPluginDelegate,
           let shouldShowLoadingView = showLoadingView.shouldShowLoadingView,shouldShowLoadingView {
            DispatchQueue.main.async {
                SVProgressHUD.popActivity() // 请求完成时隐藏 Toast
                
            }
            
            switch result{
            case.success:
                doNothing()
                //                businessHUD(response)
            case .failure(let error):
                
                DispatchQueue.main.async{
                    
                    SVProgressHUD.showError(withStatus: error.errorDescription)
                }
                
                
            }
        }
        
        
        
    }
    func doNothing(){
        
    }
    func businessHUD(_  response:Response){
        if let json = try? response.mapJSON() as? [String:[String:Any]]{
            if let retFlag = json["head"]?["retFlag"] as? String{
                if retFlag == "00000"{
                    //                    let retMsg = json["head"]?["retMsg"] as? String
                    //                    SVProgressHUD.showSuccess(withStatus: retMsg)
                }else{
                    let retMsg = json["head"]?["retMsg"] as? String
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: DispatchWorkItem(block: {
                        SVProgressHUD.showError(withStatus: retMsg)
                    }))
                    
                }
            }
            
        }else if let json = try? response.mapJSON() as? [String:String]{
            DispatchQueue.main.async {
                SVProgressHUD.showError(withStatus: json["error_description"])
                
            }
        }else if let mapString = try? response.mapString(){
            DispatchQueue.main.async {
                
                SVProgressHUD.showError(withStatus: mapString)
            }
            
        }else{
            DispatchQueue.main.async {
                
                SVProgressHUD.showError(withStatus: response.description)
            }
            
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
