//
//  String+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Foundation
import CryptoKit
import CommonCrypto
import MapKit
extension String {
    var md5: String {
        Insecure.MD5
            .hash(data: Data(self.utf8))
            .map {String(format: "%02x", $0)}
            .joined()
    }
    //地图标点骑行时间显示格式
    static func formatTime(seconds: TimeInterval) -> String {
        if seconds > 60 {
            let minutes = Int(seconds) / 60
            let remainingSeconds = Int(seconds) % 60
            return "\(minutes) 分钟 \(remainingSeconds) 秒"
        } else {
            return "\(Int(seconds)) 秒"
        }
    }
    //地图标点骑行距离显示格式
    static func formatDistance(meters: CLLocationDistance) -> String {
        if meters > 1000 {
            let kilometers = meters / 1000
            return String(format: "%.2f 公里", kilometers)
        } else {
            return String(format: "%.0f 米", meters)
        }
    }
    // 替换字符串后两位为 "00"
    func replacingLastTwoCharactersWithZeroes() -> String {
        guard self.count > 2 else {
            return self
        }
        
        let endIndex = self.index(self.endIndex, offsetBy: -2)
        let replacedString = self[..<endIndex] + "00"
        return String(replacedString)
    }
}
extension Notification.Name {
    static let userLoggedIn = Notification.Name("UserLoggedInNotification")
    static let userLoggedOut = Notification.Name("UserLoggedOutNotification")
    static let userAuthenticated = Notification.Name("UserAuthenticatedNotification")
    static let cityChanged = Notification.Name("CityChanged")
    static let relocated = Notification.Name("Relocated")
    static let scanTypeChanged = Notification.Name("ScanTypeChanged")
    static let refreshCouponList = Notification.Name("refreshCouponList")
    static let refreshDeviceNotification = Notification.Name("refreshDeviceNotification")
    static let floatButtonShowNotification = Notification.Name("floatButtonShowNotification")

}
extension String {
    func timeRemaining() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "zh_Hans_CN")

        guard let date = formatter.date(from: self) else {
            return "Invalid date format"
        }

        let now = Date()
        let timeDifference = date.timeIntervalSince1970 - now.timeIntervalSince1970

        if timeDifference < 0 {
            return "已过期"
        } else if timeDifference < 24 * 60 * 60 {
            let hours = Int(floor(timeDifference / (60 * 60)))
            return "\(hours)小时"
        } else {
            let days = Int(floor(timeDifference / (24 * 60 * 60)))
            return "\(days)天"
        }
    }
    func overdueOrExpiringSoon() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "zh_Hans_CN")
        guard let date = formatter.date(from: self) else {
            return true
        }
        let now = Date()
        let timeDifference = date.timeIntervalSince1970 - now.timeIntervalSince1970

        if timeDifference < 0 {
            return true
        } else if timeDifference < 24 * 60 * 60 {
            let hours = Int(floor(timeDifference / (60 * 60)))
            return true
        } else {
            let days = Int(floor(timeDifference / (24 * 60 * 60)))
            return false
        }
    }
}
extension String{
    func maskPhoneNumber() -> String {
        guard self.count == 11 else { return self } // 确保是11位手机号
        
        let start = self.prefix(3) // 获取前三位
        let end = self.suffix(4)    // 获取后四位
        return "\(start)****\(end)"         // 拼接成新的格式
    }
}
extension String{
    //HF 图片路径
    static func imageURLPath(with photo:String) -> String {
        let accessToken = HFKeyedArchiverTool.account().accessToken
        return "\(rootRequest)/app/api/normal/read/photo?access_token=\(accessToken)&photo=\(photo)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
    }
}
extension String {
  func formattedDate(format: String = "yyyy-MM-dd") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      print("Error: Unable to parse date string: \(self)")
      return nil
    }
    return dateFormatter.string(from: date)
  }

  // Specific formatting methods (optional)
  func formattedAsChineseYearMonthDay() -> String? {
    return formattedDate(format: "yyyy年MM月dd日")
  }

  func formattedAsWeekDay() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE" // Get weekday name
    guard let date = dateFormatter.date(from: self) else {
      return nil
    }
    return dateFormatter.string(from: date)
  }
}
