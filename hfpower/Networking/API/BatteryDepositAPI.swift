//
//  BatteryDepositAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/15.
//

import Foundation
import Moya

enum BatteryDepositAPI {
    // Define your endpoints here
    case batteryStorageInitiate
    case batteryTempOrderInfo
    case cabinetScanTemp
    case cabinetScanRelief
    case batteryScanRelief
    case cabinetScanTempConfirm
    case cabinetScanReliefConfirm
    case batteryScanReliefConfirm
}

extension BatteryDepositAPI: APIType {
    var authorizationType: HFAuthorizationType? {
        return .bearer
    }
    
    
    
    var path: String {
        switch self {
        case .batteryStorageInitiate:
            return "battery/storage/initiate"
        case .batteryTempOrderInfo:
            return "batteryTemp/order/info"
        case .cabinetScanTemp:
            return "cabinet/scanTemp"
        case .cabinetScanRelief:
            return "cabinet/scanRelief"
        case .batteryScanRelief:
            return "battery/scanRelief"
        case .cabinetScanTempConfirm:
            return "cabinet/temp/confirm"
        case .cabinetScanReliefConfirm:
            return "cabinet/relief/confirm"
        case .batteryScanReliefConfirm:
            return "battery/relief/confirm"
        }
    }
    
    var method: Moya.Method {
        // Define HTTP method for each endpoint if needed
        return .get // Example: return .post for POST requests
    }
    
    var task: Task {
        // Define task for each endpoint if needed (e.g., parameters, headers)
        switch self {
        case .batteryTempOrderInfo:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
            
        }
    }
    
    var sampleData: Data {
        // Define sample data for testing purposes if needed
        return Data()
    }
    
    var headers: [String: String]? {
        // Define headers for each endpoint if needed
        return nil
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
