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
    case login(username: String, password: String)
    case loginWithSMS(phoneNumber: String, code: String)
    case register(phoneNumber: String, inviteCode: String, code: String)
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
        case .login, .loginWithSMS:
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
            var params = ["body": ["phone_number": phoneNumber], "head": appHeader] as [String : Any]

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .login(let username, let password):
            var params = ["body": ["username": username, "password": password], "head": appHeader] as [String : Any]

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .loginWithSMS(let phoneNumber, let code):
            var params = ["body": ["phone_number": phoneNumber, "code": code], "head": appHeader] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .register(let phoneNumber, let inviteCode, let code):
            var params = ["body": ["phone_number": phoneNumber, "invite_code": inviteCode, "code": code], "head": appHeader] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .logout:
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .logoff:
            return .requestCompositeParameters(bodyParameters: [:], bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .refreshToken(let refreshToken):
            var params = ["body": ["refreshToken": refreshToken], "head": appHeader] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    var appHeader:[String:String]{
        return ["createTime":Date().currentTimeString,"requestNo":"\(Int.requestNo)","access_token":UserDefaults.standard.string(forKey: "access_token") ?? ""]

    }
    
    
}


