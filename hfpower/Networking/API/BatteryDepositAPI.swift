//
//  BatteryDepositAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/15.
//

import Foundation
import Moya

enum API {
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

extension API: APIType {
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
        return .requestPlain
    }
    
    var sampleData: Data {
        // Define sample data for testing purposes if needed
        return Data()
    }
    
    var headers: [String: String]? {
        // Define headers for each endpoint if needed
        return nil
    }
}
