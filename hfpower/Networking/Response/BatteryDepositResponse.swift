//
//  BatteryDepositResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
import KakaJSON
struct BatteryDepositResponse:Convertible {
    var id: Int?
    var deleted: Bool?
    var orderNo: String?
    var memberId: Int?
    var originalOrderId: Int?
    var batteryId: Int?
    var agentId: Int?
    var storeId: Int?
    var batteryTypeId: Int?
    var batteryNo: String?
    var tempStorageDailyPrice: Double?
    var tempStorageMinimumDays: Int?
    var remainDuration: Double?
    var remainRent: Double?
    var deposit: Double?
    var authDeposit: Double?
    var canTemporaryStorageDays: Int?
    var startDate: String?
    var endDate: String?
    var status: Int?
    var getBatteryDate: String?
    var actualTemporaryStorageDays: String?
    var tempStorageTotalPrice: Double?
    var payMethod: Int?
    var payDate: String?
    var refundDate: String?
    var agentName: String?
    var storeName: String?
    var batteryTypeName: String?
    var memberName: String?
    var memberPhone: String?
}
