//
//  AccountManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import Foundation
class AccountManager:NSObject{
    static let shared = AccountManager()
    private override init() {
        super.init()
    }
    @objc dynamic var accountIdentifier:String?{
        return phoneNum?.md5
    }

    @objc dynamic var isAuth:NSNumber?{
        get {
            return UserDefaults.standard.object(forKey: "isAuth_\(accountIdentifier ?? "")") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAuth_\(accountIdentifier ?? "")")
        }
    }
    @objc dynamic var phoneNum:String?{
        get {
            return UserDefaults.standard.string(forKey: "phoneNum")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "phoneNum")
        }
    }
    @objc dynamic var nickName:String?{
        get {
            return UserDefaults.standard.string(forKey: "nickName")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "nickName")
        }
    }
    func clearAccount(){
        nickName = nil
        phoneNum = nil
        isAuth = nil
    }

}
