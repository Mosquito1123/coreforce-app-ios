//
//  MemberAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/15.
//

import Foundation
import Moya
enum MemberAPI{
    case member
    case memberAgreement
    case activityList
    case headPic
    case nickname
    case changePwd
    case memberBind
    case memberMsg
    case memberMsgRead
    case memberRpInit
    case memberRpDescribe
    case feedback
    case memberInviteCode

}
extension MemberAPI:APIType{
    var path: String {
        switch self {
        case .member:
            return "member"
        case .memberAgreement:
            return "member/agreement"
        case .activityList:
            return "activity/list"
        case .headPic:
            return "member/headPic"
        case .nickname:
            return "member/nickname"
        case .changePwd:
            return "changePwd"
        case .memberBind:
            return "member/bind"
        case .memberMsg:
            return "member/msg"
        case .memberMsgRead:
            return "member/msg/read"
        case .memberRpInit:
            return "member/rp/init"
        case .memberRpDescribe:
            return "member/rp/describe"
        case .feedback:
            return "feedback"
        case .memberInviteCode:
            return "member/inviteCode"
        }
    }
    
    var method: Moya.Method {
        // Define HTTP method for each endpoint if needed
        return .get // Example: return .post for POST requests
    }

    var task: Task {
        // Define task for each endpoint if needed (e.g., parameters, headers)
        switch self {
        case .member:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
            
        }
    }
    
    var authorizationType: HFAuthorizationType? {
        return .bearer
    }

    var appHeader:[String:String]{
        return ["createTime":Date().currentTimeString,"requestNo":"\(Int.requestNo)","access_token":TokenManager.shared.accessToken ?? ""]

    }
    
}
