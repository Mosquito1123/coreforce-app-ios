//
//  PackageCardAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/15.
//

import Foundation
import Moya

enum PackageCardAPI {
    // Define your endpoints here
    case packageCardList
    case packageCardCount
}

extension PackageCardAPI: APIType {
    var authorizationType: HFAuthorizationType? {
        return .bearer
    }
    
    

    var path: String {
        switch self {
        case .packageCardList:
            return "payVoucher/list"
        case .packageCardCount:
            return "payVoucher/count"
        }
    }

    var method: Moya.Method {
        // Define HTTP method for each endpoint if needed
        return .get // Example: return .post for POST requests
    }

    var task: Task {
        // Define task for each endpoint if needed (e.g., parameters, headers)
        return .requestPlain
    }

    var sampleData: Data {
        // Define sample data for testing purposes if needed
        return Data()
    }
    var validationType: ValidationType{
        return .successAndRedirectCodes
    }
    var headers: [String: String]? {
        // Define headers for each endpoint if needed
        return nil
    }
    var appHeader:[String:String]{
        if let accessToken = TokenManager.shared.accessToken{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)","access_token":accessToken]
        }else{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)"]
        }
    }
}
