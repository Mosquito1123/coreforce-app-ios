//
//  BatteryListManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
class BatteryListManager:NSObject{
    static let shared = BatteryListManager()
    private override init() {
        super.init()
    }
    @objc dynamic var batteryDetail:BatteryDetail?
}
