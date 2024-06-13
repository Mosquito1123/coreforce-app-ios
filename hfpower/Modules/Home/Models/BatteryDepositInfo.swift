//
//  BatteryDepositInfo.swift
//  hfpower
//
//  Created by EDY on 2024/6/12.
//

import UIKit
import KakaJSON
class BatteryDepositInfo: NSObject,Convertible {
    
    // MARK: - Accessor
    @objc dynamic var id: NSNumber?
    @objc dynamic  var deleted: NSNumber?
    @objc dynamic var orderNo: String?
    @objc dynamic var memberId: NSNumber?
    @objc dynamic var originalOrderId: NSNumber?
    @objc dynamic var batteryId: NSNumber?
    @objc dynamic var agentId: NSNumber?
    @objc dynamic var storeId: NSNumber?
    @objc dynamic var batteryTypeId: NSNumber?
    @objc dynamic var batteryNo: String?
    @objc dynamic var tempStorageDailyPrice: NSNumber?
    @objc dynamic var tempStorageMinimumDays: NSNumber?
    @objc dynamic var remainDuration: NSNumber?
    @objc dynamic var remainRent: NSNumber?
    @objc dynamic var deposit: NSNumber?
    @objc dynamic var authDeposit: NSNumber?
    @objc dynamic var canTemporaryStorageDays: NSNumber?
    @objc dynamic var startDate: String?
    @objc dynamic var endDate: String?
    @objc dynamic var status: NSNumber?
    @objc dynamic var getBatteryDate: String?
    @objc dynamic var actualTemporaryStorageDays: String?
    @objc dynamic var tempStorageTotalPrice: NSNumber?
    @objc dynamic var payMethod: NSNumber?
    @objc dynamic var payDate: String?
    @objc dynamic var refundDate: String?
    @objc dynamic var agentName: String?
    @objc dynamic var storeName: String?
    @objc dynamic var batteryTypeName: String?
    @objc dynamic var memberName: String?
    @objc dynamic var memberPhone: String?
    // MARK: - Lifecycle
    required override init() {
        super.init()
        
    }
    class func fromStruct(_ bd:BatteryDepositResponse?)->BatteryDepositInfo? {
        let model =  bd?.kj.JSONString().kj.model(BatteryDepositInfo.self)
        return model
    }
}

// MARK: - Public
extension BatteryDepositInfo {
    
}

// MARK: - Private
private extension BatteryDepositInfo {
    
}
