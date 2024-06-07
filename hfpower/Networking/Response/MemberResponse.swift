//
//  MemberResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import Foundation
import KakaJSON
// MARK: - Body
struct MemberResponse: Convertible {
    var depositData: DepositData?
    var locomotive: Locomotive?
    var member: Member?
    var payVoucherCount: Int?
    var orderData: OrderData?
    var msgData: MsgData?
    var couponData: CouponData?
}

// MARK: - DepositData
struct DepositData: Convertible {
    var locomotiveRefundDeposit: Double?
    var locomotiveDeposit: Double?
    var batteryDeposit: Double?
    var batteryRefundDeposit: Double?
}

// MARK: - Locomotive
struct Locomotive: Convertible {
    var id: Int?
    var vin: String?
    var number: String?
    var licensePlate: String?
    var status: Int?
    var storeId: Int?
    var mac: String?
    var planId: Int?
    var storeName: String?
    var agentId: Int?
    var agentName: String?
    var planName: String?
    var planDeposit: Double?
    var planRent: Double?
    var memberId: Int?
    var locomotiveStartDate: String?
    var locomotiveEndDate: String?
    var memberNickname: String?
    var memberRealName: String?
    var memberPhoneNum: String?
    var orderRent: Double?
    var orderDeposit: Double?
    var originalOrderId: Int?
}

// MARK: - Member
struct Member: Convertible {
    var id: Int?
    var nickname: String?
    var phoneNum: String?
    var realName: String?
    var idCard: String?
    var isAuth: Int?
    var headPic: String?
    var miniOpenid: String?
    var appOpenid: String?
    var status: Int?
    var authingAt: String?
    var authAt: String?
    var agreement: Bool?
    var agreementAt: String?
    var unionid: String?
    var inviteCode: String?
    var wallet: Double?
    var walletStatus: Int?
    var createAt: String?
    var isSetPwd: Bool?
}

// MARK: - OrderData
struct OrderData: Convertible {
    var paidCount: Int?
    var payingCount: Int?
}

// MARK: - MsgData
struct MsgData: Convertible {
    var unreadCount: Int?
    var allCount: Int?
}

// MARK: - CouponData
struct CouponData: Convertible {
    var usableCount: Int?
    var allCount: Int?
}
