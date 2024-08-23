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
//    var md5: String {
//        let data = Data(self.utf8)
//        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
//            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
//            return hash
//        }
//        return hash.map { String(format: "%02x", $0) }.joined()
//    }
}
extension Notification.Name {
    static let userLoggedIn = Notification.Name("UserLoggedInNotification")
    static let userLoggedOut = Notification.Name("UserLoggedOutNotification")
    static let userAuthenticated = Notification.Name("UserAuthenticatedNotification")
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
