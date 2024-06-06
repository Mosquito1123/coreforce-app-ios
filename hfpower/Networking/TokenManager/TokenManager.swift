//
//  TokenManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "accessToken")
        }
    }

    var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "refreshToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshToken")
        }
    }

    var accessTokenExpiration: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessTokenExpiration")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "accessTokenExpiration")
        }
    }

    var refreshTokenExpiration: String? {
        get {
            return UserDefaults.standard.string(forKey: "refreshTokenExpiration")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshTokenExpiration")
        }
    }

   

    func clearTokens() {
        accessToken = nil
        refreshToken = nil
        accessTokenExpiration = nil
        refreshTokenExpiration = nil
    }
    public var hasValidToken: Bool {
        guard let lastTokenDateString = UserDefaults.standard.string(forKey: "accessTokenExpiration") else {return false}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         
        guard let tokenDate = dateFormatter.date(from: lastTokenDateString) else { return false }
        
        let diff = Date().timeIntervalSince1970 - tokenDate.timeIntervalSince1970
        
        // If last token is > 23 hours, we should refresh the token
        return diff < 82800
    }
}
