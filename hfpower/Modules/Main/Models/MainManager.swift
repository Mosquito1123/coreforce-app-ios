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
    
}

// MARK: - Public
extension MainManager {
    
}

// MARK: - Private
private extension MainManager {
    
}
