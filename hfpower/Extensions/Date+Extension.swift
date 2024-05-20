//
//  Date+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Foundation
extension Date {
    var currentTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "zh_Hans_CN")
        return formatter.string(from: self)
    }
    
}
