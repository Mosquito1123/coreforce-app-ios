//
//  CityCodeManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import Foundation
import CoreLocation
class CityCodeManager:NSObject {
    static let cityHistory = "cityHistory"
    static let shared = CityCodeManager()
    private override init() {
        super.init()
    }
    @objc dynamic var tempCityCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "tempCityCode")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "tempCityCode")
        }
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
    let maxHistoryCount = 5 // 设置最大历史记录数
    
    // 存储新城市到历史记录，并去重
    func saveToHistory(newValue: City) {
        let encoder = JSONEncoder()
        
        // 读取历史记录数组
        var history: [City] = getHistory()
        
        // 去重处理：如果历史记录中已经存在相同城市，先移除
        if let existingIndex = history.firstIndex(where: { $0.cityCode == newValue.cityCode }) {
            history.remove(at: existingIndex)
        }
        
        // 添加新值到数组开头
        history.insert(newValue, at: 0)
        
        // 保证历史记录不超过最大数量
        if history.count > maxHistoryCount {
            history = Array(history.prefix(maxHistoryCount))
        }
        
        // 将更新后的数组进行编码
        if let encodedData = try? encoder.encode(history) {
            // 将更新后的数组存回 UserDefaults
            UserDefaults.standard.set(encodedData, forKey: CityCodeManager.cityHistory)
        }
    }
    
    // 获取历史记录
    func getHistory() -> [City] {
        if let savedData = UserDefaults.standard.data(forKey: CityCodeManager.cityHistory) {
            let decoder = JSONDecoder()
            if let decodedHistory = try? decoder.decode([City].self, from: savedData) {
                return decodedHistory
            }
        }
        return []
    }
    
    
    
    
}
struct City: Codable {
    let cityCode: String?
    let cityName: String?
}
