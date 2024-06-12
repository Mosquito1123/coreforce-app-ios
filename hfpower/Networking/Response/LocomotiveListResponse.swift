//
//  LocomotiveListResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
import KakaJSON
// MARK: - Body
struct DataListResponse<T:Convertible>: Convertible {
    var pageResult: PageResult<T>?
}

// MARK: - PageResult
struct PageResult<T:Convertible>: Convertible {
    var page: Int?
    var size: Int?
    var total: Int?
    var dataList: [T]?
}

// MARK: - Locomotive
struct LocomotiveSummary: Convertible {
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
