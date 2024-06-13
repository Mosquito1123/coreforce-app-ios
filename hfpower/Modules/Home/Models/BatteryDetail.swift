//
//  BatteryDetail.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import UIKit
import KakaJSON
class BatteryDetail: NSObject,Convertible {
    
    // MARK: - Accessor
    @objc dynamic var ambientTemperature: NSNumber?
    @objc dynamic var batteryTemperature2: NSNumber?
    @objc dynamic var clientLock: NSNumber?
    @objc dynamic var id:NSNumber?
    @objc dynamic var lockStatus: NSNumber?
    @objc dynamic var mcuAmbientTemp: NSNumber?
    @objc dynamic var mcuBatteryTemp: NSNumber?
    @objc dynamic var mcuBatteryTemp2:NSNumber?
    @objc dynamic var mcuCapacityPercent: NSNumber?
    @objc dynamic var mcuLock: NSNumber?
    @objc dynamic var memberPhoneNum: NSNumber?
    @objc dynamic var onLine: NSNumber?
    @objc dynamic var originalOrderId: NSNumber?
    @objc dynamic var planId: NSNumber?
    @objc dynamic var ratedMileage: NSNumber?
    @objc dynamic var remainCapacity: NSNumber?
    @objc dynamic var startChargeTimes: NSNumber?
    @objc dynamic var status: NSNumber?
    @objc dynamic var batteryEndDate: String?
    @objc dynamic var batteryName: String?
    @objc dynamic var batteryStartDate: String?
    @objc dynamic var batteryStartMileage: String?
    @objc dynamic var generalParamsAt: String?
    @objc dynamic var gpsAt: String?
    @objc dynamic var lastMcuTime: String?
    @objc dynamic var memberNickname: String?
    @objc dynamic var memberRealName: String?
    @objc dynamic var name: String?
    @objc dynamic var agentName: String?
    @objc dynamic var agentId: NSNumber?
    @objc dynamic var number: String?
    @objc dynamic var gdLat: NSNumber?
    @objc dynamic var gdLon: NSNumber?
    @objc dynamic var lastLat: NSNumber?
    @objc dynamic var lastLon: NSNumber?
    @objc dynamic var mcuCurrent: NSNumber?
    @objc dynamic var mcuVoltage: NSNumber?
    @objc dynamic var mileage: NSNumber?
    @objc dynamic var changeFeeStatus: NSNumber?
    @objc dynamic var changeFeeAmount: NSNumber?
    @objc dynamic var changeCountLimit: NSNumber?
    @objc dynamic var singleChangeFeeAmount: NSNumber?
    @objc dynamic var isRefundChangeFee: NSNumber?
    @objc dynamic var changeEndDateMember: String?
    @objc dynamic var changeRemainTimesMember: NSNumber?
    // MARK: - Lifecycle
    required override init() {
        super.init()
        
    }
    class func fromStruct(_ bd:BatterySummary?)->BatteryDetail? {
        let model =  bd?.kj.JSONString().kj.model(BatteryDetail.self)
        return model
    }
}

// MARK: - Public
extension BatteryDetail {
    
}

// MARK: - Private
private extension BatteryDetail {
    
}
