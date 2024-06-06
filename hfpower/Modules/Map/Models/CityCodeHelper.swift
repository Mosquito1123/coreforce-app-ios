//
//  CityCodeHelper.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import Foundation

class CityCodeHelper {
    var locationData: [[String: Any]] = []

    init() {
        if let filePath = Bundle.main.path(forResource: "area", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
            self.locationData = jsonObject
        } else {
            print("Error parsing JSON")
        }
    }
    
    func findCodeByName(_ name: String, _ items: [[String: Any]]) -> String? {
        for item in items {
            if let itemName = item["name"] as? String, itemName == name {
                return item["code"] as? String
            }
            
            if let children = item["children"] as? [[String: Any]], !children.isEmpty {
                if let foundCode = findCodeByName(name, children) {
                    return foundCode
                }
            }
        }
        return nil
    }

    func findNameByCode(_ code: String, _ items: [[String: Any]]) -> String? {
        for item in items {
            if let itemCode = item["code"] as? String, itemCode == code {
                return item["name"] as? String
            }
            
            if let children = item["children"] as? [[String: Any]], !children.isEmpty {
                if let foundName = findNameByCode(code, children) {
                    return foundName
                }
            }
        }
        return nil
    }
    
    func getCodeByName(_ name: String) -> String? {
        return findCodeByName(name, locationData)
    }
    
    func getNameByCode(_ code: String) -> String? {
        return findNameByCode(code, locationData)
    }
}


