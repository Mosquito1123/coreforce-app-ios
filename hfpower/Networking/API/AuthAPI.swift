//
//  AuthAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Foundation
import Alamofire
import Moya
enum AuthAPI {
    case refreshToken(refreshToken:String)
    case logout
    case logoff
    case sendSMSCode(phoneNumber: String)
    case login(username: String, password: String,type:String)
    case wxLogin(code:String)
    case loginWithSMS(phoneNumber: String, code: String,inviteCode:String? = nil,type:String)
    case register(phoneNumber: String, inviteCode: String? = nil, code: String,type:String)
}
extension AuthAPI:APIType{
    var authorizationType: HFAuthorizationType? {
        return .bearer
    }
    
    var shouldShowLoadingView: Bool? {
        return true
    }
    
    
    var path: String {
        switch self {
        
        case .sendSMSCode:
            return "pin/send"
        case .login,.loginWithSMS:
            return "login"
        case .wxLogin:
            return "wxLogin"
        case .register:
            return "reg"
        case .logoff:
            return "logoff"
        case .logout:
            return "logout"
        case .refreshToken:
            return "refreshToken"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendSMSCode, .login, .loginWithSMS, .register,.logoff,.logout,.wxLogin:
            return .post
        case .refreshToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendSMSCode(let phoneNumber):
            let params = ["body": ["phoneNum": phoneNumber]] as [String : Any]

            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .login(let username, let password,let type):
            
            let params = ["body": ["account": username, "password": password.md5,"type":type]] as [String : Any]

            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .loginWithSMS(let phoneNumber, let code,let inviteCode,let type):
            var params = ["body": ["account": phoneNumber, "password": code,"type":type]] as [String : Any]
            if let x = inviteCode{
                params["inviteCode"] = x
            }
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .register(let phoneNumber, let inviteCode, let code,let type):
            var params = ["body": ["account": phoneNumber, "password": code,"type":type]] as [String : Any]
            if let x = inviteCode{
                params["inviteCode"] = x
            }
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .logout:
            let params = ["body":[:]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .logoff:
            let params = ["body":[:]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .refreshToken(let refreshToken):
            let params = ["refresh_token": refreshToken]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        case .wxLogin(code: let code):
            let params = ["body": ["code":code]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader["access_token"] == nil ? [:]:appHeader)
        }
    }
    
 
    var validationType: ValidationType{
        return .successAndRedirectCodes
    }
    var appHeader:[String:String]{
        if let accessToken = TokenManager.shared.accessToken{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)","access_token":accessToken]
        }else{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)"]
        }
    }
    
    
}


