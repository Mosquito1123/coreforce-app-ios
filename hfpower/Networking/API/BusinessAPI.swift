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
    case cabinetScan(cabinetNumber:String?,batteryId:Int?)
    case cabinetScanReturn
    case replaceConfirm
    case cabinet(id:String?,number:String?)
    case cabinetList(tempStorageSw:NSNumber?,cityCode:String?,lon:Double?,lat:Double?)
    case cabinetScanRent(cabinetNumber:String?)
    case batteryLock
    case batteryUnlock
    case batteryRing(batteryId:Int)
    case lockStatus
    case cabinetStatus(opNo:String)
    case couponMatchingCount
    case battery
    case renewal
    case order(id:Int)
    case orderCancel(orderId:Int)
    case batteryTimeChangeCardCancel
    case orderPay
    case batteryTimeChangeCardPay
    case locomotiveCouponCount
    case locomotive
    case batteryReturn
    case orderList(page:Int)
    case batteryTimeChangeCardList
    case couponMatching(amount:Double,page:Int,batteryNumber:String?)
    case locomotiveCouponMatching(amount:Double,page:Int,locomotiveNumber:String?)
    case changeCardCouponMatching(amount:Double,page:Int,batteryNumber:String?)
    case couponList(page:Int)
    case couponReceive(code:String)
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
         // Example: return .post for POST requests
        switch self {
        case .couponReceive:
            return .post
        case .orderCancel:
            return .post
        case .cabinetScan:
            return .post
        case .cabinetScanRent:
            return .post
        case .cabinet:
            return .get
        case .cabinetStatus:
            return .get
        case .batteryRing:
            return .post
        default:
            return .get
        }
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
        case .cabinet(id: let id, number: let number):
            var params = [String:Any]()
            if let idx = id{
                params["id"] = idx
            }
            if let numberx = number{
                params["number"] = numberx
            }
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .cabinetStatus(opNo: let opNo):
            var params = [String:Any]()
            params["opNo"] = opNo
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .couponMatching(amount: let amount, page: let page, batteryNumber: let batteryNumber):
            var params = [String:Any]()
            params["amount"] = amount
            params["page"] = page
            if let bn = batteryNumber{
                params["batteryNumber"] = bn
            }
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .locomotiveCouponMatching(amount: let amount, page: let page, locomotiveNumber: let locomotiveNumber):
            var params = [String:Any]()
            params["amount"] = amount
            params["page"] = page
            if let bn = locomotiveNumber{
                params["locomotiveNumber"] = bn
            }
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .changeCardCouponMatching(amount: let amount, page: let page, batteryNumber: let batteryNumber):
            var params = [String:Any]()
            params["amount"] = amount
            params["page"] = page
            if let bn = batteryNumber{
                params["batteryNumber"] = bn
            }
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .couponList(page: let page):
            var params = [String:Any]()
            params["page"] = page
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .couponReceive(code: let code):
            let params = ["head": appHeader,"body":["code":code]]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .cabinetScan(cabinetNumber: let cabinetNumber, batteryId: let batteryId):
            let params = ["head": appHeader,"body":["cabinetNumber":cabinetNumber ?? "","batteryId":batteryId ?? 0]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .cabinetScanRent(cabinetNumber:let cabinetNumber):
            let params = ["head": appHeader,"body":["cabinetNumber":cabinetNumber ?? ""]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .batteryRing(batteryId: let batteryId):
            let params = ["head": appHeader,"body":["batteryId":batteryId]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
        case .orderList(page:let page):
            var params = [String:Any]()
            params["page"] = page
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .order(id: let id):
            var params = [String:Any]()
            params["id"] = id
            for item in appHeader {
                params[item.key] = item.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .orderCancel(orderId: let orderId):
            let params = ["head": appHeader,"body":["orderId":orderId]] as [String : Any]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: appHeader)
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
        if let accessToken = TokenManager.shared.accessToken{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)","access_token":accessToken]
        }else{
            return ["createTime":Date().currentTimeString,"requestNo":"\(UInt32.requestNo)"]
        }
    }
    var shouldShowLoadingView: Bool?{
        return false
    }
    
}
