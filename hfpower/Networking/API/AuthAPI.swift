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
        case .sendSMSCode, .login, .loginWithSMS, .register,.logoff,.logout:
            return .post
        case .refreshToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendSMSCode(let phoneNumber):
            let params = ["body": ["phoneNum": phoneNumber], "head": appHeader] as [String : Any]

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .login(let username, let password,let type):
            
            let params = ["body": ["account": username, "password": password.md5,"type":type], "head": appHeader] as [String : Any]

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .loginWithSMS(let phoneNumber, let code,let inviteCode,let type):
            var params = ["body": ["account": phoneNumber, "password": code,"type":type], "head": appHeader] as [String : Any]
            if let x = inviteCode{
                params["inviteCode"] = x
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .register(let phoneNumber, let inviteCode, let code,let type):
            var params = ["body": ["account": phoneNumber, "password": code,"type":type], "head": appHeader] as [String : Any]
            if let x = inviteCode{
                params["inviteCode"] = x
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .logout:
            let params = ["head": appHeader,"body":[:]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .logoff:
            let params = ["head": appHeader,"body":[:]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .refreshToken(let refreshToken):
            let params = ["body": ["refreshToken": refreshToken], "head": appHeader] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    var appHeader:[String:String]{
        return ["createTime":Date().currentTimeString,"requestNo":"\(Int.requestNo)","access_token":TokenManager.shared.accessToken ?? ""]

    }
    
    
}


