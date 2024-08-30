//
//  OrderDetail.swift
//  hfpower
//
//  Created by EDY on 2024/8/19.
//

import Foundation
import KakaJSON
struct OrderDetail:Convertible{
    var agentId: Int?
    var authOrderStatus: Int?
    var batteryChargeTimes: Int?
    var batteryId: Int?
    var cabinetId: Int?
    var channelOrderNo: Int?
    var deviceType: Int?
    var duration: Int?
    var gridId: Int?
    var gridNum: Int?
    var id: Int?
    var leaseDuration: Int?
    var lossAmount: Double?
    var couponDiscountAmount: Double?
    var couponLimitAmount: Double?
    var couponId: Int?
    var memberId: Int?
    var memberPhoneNum: String?
    var orderNo: String?
    var originalOrderId: Int?
    var overdueAmount: Double?
    var payMethod: Int?
    var payStatus: Int?
    var pid: Int?
    var planId: Int?
    var refundChannel: Int?
    var refundRent: Double?
    var refundStatus: Int?
    var name: String?
    var storeId: Int?
    var type: Int?
    var unfreeze: Int?
    var agentName: String?
    var appid: String?
    var batteryNumber: String?
    var batteryTypeName: String?
    var buyerId: String?
    var createAt: String?
    var endDate: String?
    var forceAt: String?
    var forceUserName: String?
    var fundChannel: String?
    var memberRealName: String?
    var nickname: String?
    var payDate: String?
    var planName: String?
    var refundDate: String?
    var refundLaunchDate: String?
    var refundMemo: String?
    var reviewName: String?
    var startDate: String?
    var storeName: String?
    var tradeType: String?
    var locomotiveNumber: String?
    var batteryMileage: Double?
    var deposit: Double?
    var paidAmount: Double?
    var paidRefundAmount: Double?
    var payableAmount: Double?
    var refundAmount: Double?
    var refundDeposit: Double?
    var rent: Double?
    var totalAmount: Double?
    var payVoucherDays: Int?
    var items:[OrderDetailItem] = [OrderDetailItem]()
}
struct OrderDetailItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var extra:String?
    
}
