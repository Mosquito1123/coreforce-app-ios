//
//  Coupon.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import Foundation
import KakaJSON
struct Coupon:Convertible{
    var id:Int?
    var title:String?
    var status:Int?
    var agentNames: String?
    var endDate: String?
    var name: String?
    var phoneNum: String?
    var realName: String?
    var startDate: String?
    var storeNames: String?
    var discountAmount: Double?
    var limitAmount: Double?
    var couponType: Int?
    var couponTypeId: Int?
    var deviceType: Int?
    var freeDepositCount: Int?
    var freeDepositTimes: Int?
    var memberId: Int?
}
