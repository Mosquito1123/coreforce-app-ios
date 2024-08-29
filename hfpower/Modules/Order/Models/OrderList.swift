//
//  OrderList.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import Foundation
import KakaJSON
struct OrderList:Convertible{
    var id:Int?
    var title:String?
    var status:Int?
    var type:Int?
    var agentName: String?
    var batteryNumber: String?
    var batteryTypeName: String?
    var createAt: String?
    var endDate: String?
    var memberRealName: String?
    var nickname: String?
    var planName: String?
    var startDate: String?
    var storeName: String?
    var agentId: Int?
    var batteryChargeTimes: Int?
    var batteryId: Int?
    var deviceType: Int?
    var duration: Int?
    var leaseDuration: Int?
    var memberId: Int?
    var memberPhoneNum: Int?
    var orderNo: String?
    var payStatus: Int?
    var planId: Int?
    var storeId: Int?
    var batteryMileage: Double?
    var deposit: Double?
    var payableAmount: Double?
    var payableRent: Double?
    var rent: Double?
    var totalAmount: Double?
    var couponDiscountAmount: Double?
}
