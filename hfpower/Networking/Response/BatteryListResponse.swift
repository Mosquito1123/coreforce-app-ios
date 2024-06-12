//
//  BatteryListResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
import KakaJSON



struct BatterySummary:Convertible{
    var ambientTemperature: Int?
    var batteryTemperature2: Int?
    var clientLock: Int?
    var id: Int?
    var lockStatus: Int?
    var mcuAmbientTemp: Int?
    var mcuBatteryTemp: Int?
    var mcuBatteryTemp2: Int?
    var mcuCapacityPercent: Int?
    var mcuLock: Int?
    var memberPhoneNum: Int?
    var onLine: Bool?
    var originalOrderId: Int?
    var planId: Int?
    var ratedMileage: Int?
    var remainCapacity: Int?
    var startChargeTimes: Int?
    var status: Int?
    var batteryEndDate: String?
    var batteryName: String?
    var batteryStartDate: String?
    var batteryStartMileage: String?
    var generalParamsAt: String?
    var gpsAt: String?
    var lastMcuTime: String?
    var memberNickname: String?
    var memberRealName: String?
    var name: String?
    var agentName: String?
    var agentId: NSNumber?
    var number: String?
    var gdLat: Double?
    var gdLon: Double?
    var lastLat: Double?
    var lastLon: Double?
    var mcuCurrent: Double?
    var mcuVoltage: Double?
    var mileage: Double?
    var changeFeeStatus: Bool?
    var changeFeeAmount: Double?
    var changeCountLimit: Int?
    var singleChangeFeeAmount: Double?
    var isRefundChangeFee: Bool?
    var changeEndDateMember: String?
    var changeRemainTimesMember: Int?
}
