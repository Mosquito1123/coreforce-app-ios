//
//  CityCodeManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import Foundation
import CoreLocation
class CityCodeManager:NSObject {
    static let shared = CityCodeManager()
    private override init() {
        super.init()
    }
    
    @objc dynamic var cityCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "cityCode")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "cityCode")
        }
    }
    @objc dynamic var cityName: String? {
        get {
            return UserDefaults.standard.string(forKey: "cityName")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "cityName")
        }
    }
    @objc dynamic var placemark:CLPlacemark?
    func clearCityCode() {
        cityCode = nil
        cityName = nil
        placemark = nil
    }
}
