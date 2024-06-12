//
//  BikeDetail.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import UIKit
import KakaJSON
class BikeDetail: NSObject,Convertible {
    
    // MARK: - Accessor
    @objc dynamic var id: NSNumber?
    @objc dynamic var vin: String?
    @objc dynamic var number: String?
    @objc dynamic var licensePlate: String?
    @objc dynamic var status: NSNumber?
    @objc dynamic var storeId: NSNumber?
    @objc dynamic var mac: String?
    @objc dynamic var planId: NSNumber?
    @objc dynamic var storeName: String?
    @objc dynamic var agentId: NSNumber?
    @objc dynamic var agentName: String?
    @objc dynamic var planName: String?
    @objc dynamic var planDeposit: NSNumber?
    @objc dynamic var planRent: NSNumber?
    @objc dynamic var memberId: NSNumber?
    @objc dynamic var locomotiveStartDate: String?
    @objc dynamic var locomotiveEndDate: String?
    @objc dynamic var memberNickname: String?
    @objc dynamic var memberRealName: String?
    @objc dynamic var memberPhoneNum: String?
    @objc dynamic var orderRent: NSNumber?
    @objc dynamic var orderDeposit: NSNumber?
    @objc dynamic var originalOrderId: NSNumber?
    
    // MARK: - Lifecycle
    required override init() {
        super.init()
        
    }
    
}

// MARK: - Public
extension BikeDetail {
    
}

// MARK: - Private
private extension BikeDetail {
    
}
