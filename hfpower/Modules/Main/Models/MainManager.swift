//
//  MainManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/12.
//

import UIKit

class MainManager: NSObject {
    static let shared = MainManager()
    // MARK: - Accessor
    @objc dynamic var batteryDetail:BatteryDetail?
    @objc dynamic var bikeDetail:BikeDetail?
    @objc dynamic var batteryDeposit:BatteryDepositInfo?

    @objc dynamic var type:NSNumber?
    // MARK: - Lifecycle
    override init() {
        super.init()
        
    }
    func refreshType(){
        var type:NSNumber = 0
        if MainManager.shared.batteryDeposit?.id != nil{
            type = 2
        }else{
            if MainManager.shared.batteryDetail?.id != nil{
                type = 1
            }else{
                type = 0
            }
        }
        MainManager.shared.type = type
    }
    
}

// MARK: - Public
extension MainManager {
    func resetAll(){
        batteryDetail = nil
        bikeDetail = nil
        batteryDeposit = nil
        type = 0
    }
}

// MARK: - Private
private extension MainManager {
    
}
