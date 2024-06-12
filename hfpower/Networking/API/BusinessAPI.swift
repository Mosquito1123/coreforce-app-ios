//
//  BusinessAPI.swift
//  hfpower
//
//  Created by EDY on 2024/4/15.
//

import Foundation
import Alamofire
import Moya
enum BusinessAPI {
    case batteryList
    case locomotiveList
    case cabinetScan
    case cabinetScanReturn
    case replaceConfirm
    case cabinet
    case cabinetList(tempStorageSw:NSNumber?,cityCode:String?,lon:Double?,lat:Double?)
    case cabinetScanRent
    case batteryLock
    case batteryUnlock
    case batteryRing
    case lockStatus
    case cabinetStatus
    case couponMatchingCount
    case battery
    case renewal
    case order
    case orderCancel
    case batteryTimeChangeCardCancel
    case orderPay
    case batteryTimeChangeCardPay
    case locomotiveCouponCount
    case locomotive
    case batteryReturn
    case orderList
    case batteryTimeChangeCardList
    case couponMatching
    case locomotiveCouponMatching
    case changeCardCouponMatching
    case couponList
    case couponReceive
    case batteryTimeChangeCardPlanList
    case returnCheck
}
extension BusinessAPI:APIType{
    var path: String {
        switch self {
        case .batteryList:
            return "battery/list"
        case .locomotiveList:
            return "locomotive/list"
        case .cabinetScan:
            return "cabinet/scan"
        case .cabinetScanReturn:
            return "cabinet/scanReturn"
        case .replaceConfirm:
            return "cabinet/replace/confirm"
        case .cabinet:
            return "cabinet"
        case .cabinetList:
            return "cabinet/list"
        case .cabinetScanRent:
            return "cabinet/scanRent"
        case .batteryLock:
            return "battery/lock"
        case .batteryUnlock:
            return "battery/unlock"
        case .batteryRing:
            return "battery/ring"
        case .lockStatus:
            return "battery/lock/status"
        case .cabinetStatus:
            return "cabinet/status"
        case .couponMatchingCount:
            return "coupon/matching/count"
        case .battery:
            return "battery"
        case .renewal:
            return "renewal"
        case .order:
            return "order"
        case .orderCancel:
            return "order/cancel"
        case .batteryTimeChangeCardCancel:
            return "batteryTimeChangeCard/cancel"
        case .orderPay:
            return "order/pay"
        case .batteryTimeChangeCardPay:
            return "batteryTimeChangeCard/pay"
        case .locomotiveCouponCount:
            return "locomotive/coupon/matching/count"
        case .locomotive:
            return "locomotive"
        case .batteryReturn:
            return "battery/return"
        case .orderList:
            return "order/list"
        case .batteryTimeChangeCardList:
            return "batteryTimeChangeCard/list"
        case .couponMatching:
            return "coupon/matching"
        case .locomotiveCouponMatching:
            return "locomotive/coupon/matching"
        case .changeCardCouponMatching:
            return "changeCard/coupon/matching"
        case .couponList:
            return "coupon/list"
        case .couponReceive:
            return "coupon/receive"
        case .batteryTimeChangeCardPlanList:
            return "batteryTimeChangeCardPlan/list"
        case .returnCheck:
            return "battery/return/check"
        }
    }
    
    var method: Moya.Method {
        // Define HTTP method for each endpoint if needed
        return .get // Example: return .post for POST requests
    }
    
    var task: Task {
        // Define task for each endpoint if needed (e.g., parameters, headers)
        switch self {
        case .cabinetList(tempStorageSw: let tempStorageSw, cityCode: let cityCode, lon: let lon, lat: let lat):
            var params = [String:Any]()
            if let t = tempStorageSw{
                params["tempStorageSw"] = t
            }
            if let c = cityCode{
                params["cityCode"] = c
            }
            if let lon = lon{
                params["lon"] = lon
            }
            if let lat = lat{
                params["lat"] = lat
            }
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .batteryList:
            return .requestParameters(parameters: appHeader, encoding: URLEncoding.default)
        case .locomotiveList:
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
    
    var authorizationType: HFAuthorizationType? {
        return .bearer
    }
    var validationType: ValidationType{
        return .successAndRedirectCodes
    }
    var appHeader:[String:String]{
        return ["createTime":Date().currentTimeString,"requestNo":"\(Int.requestNo)","access_token":TokenManager.shared.accessToken ?? ""]

    }
    
}
