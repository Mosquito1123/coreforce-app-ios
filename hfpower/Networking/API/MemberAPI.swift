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
    case headPic(image: UIImage)
    case nickname
    case changePwd
    case memberBind
    case memberMsg
    case memberMsgRead
    case memberRpInit(params:[String:Any])
    case memberRpDescribe(certifyId:String)
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
        switch self {
        case .member:
            return .get
        case .activityList:
            return .get
        case .memberRpInit:
            return .post
        case .memberRpDescribe:
            return .post
        case .headPic:
            return .post
        default:
            return .post
            
        }
    }

    var task: Task {
        // Define task for each endpoint if needed (e.g., parameters, headers)
        switch self {
        case .member:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
        case .activityList:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
        case .memberRpInit(params:let params):
            let mParams = ["head": appHeader,"body":params]
            return .requestCompositeParameters(bodyParameters: mParams, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .memberRpDescribe(certifyId:let certifyId):
            let params = ["head": appHeader,"body":["certifyId":certifyId]]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .headPic(image: let image):
            return .uploadCompositeMultipart([
                MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1) ?? Data()), name: "file", fileName: "pic_image", mimeType: "image/jpeg"),
            ], urlParameters: appHeader)
        default:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
            
        }
    }
    var shouldShowLoadingView: Bool?{
        switch self {
        case .activityList:
            return false
        default:
            return true
        }
    }
    var authorizationType: HFAuthorizationType? {
        return .bearer
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
