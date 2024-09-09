//
//  AppDelegate.swift
//  hfpower
//
//  Created by 钟离 on 2024/4/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        WXApi.registerApp("wxfbe855af004db917", universalLink: "https://www.coreforce.cn/app/")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // 9.0 以后使用新 API 接口
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let resultWeChat = WXPayTools.sharedInstance.handleOpen(url: url)
        if resultWeChat {
            return resultWeChat
        }
        
        if url.host == "safepay" {
            // 跳转支付宝客户端进行支付，处理支付结果
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: nil)
        }
        
        AlipaySDK.defaultService()?.processAuth_V2Result(url, standbyCallback: { resultDic in
            if let result = resultDic?["result"] as? String {
                var authCode: String?
                let resultArr = result.components(separatedBy: "&")
                for subResult in resultArr where subResult.hasPrefix("auth_code=") {
                    authCode = String(subResult.dropFirst(10))
                    break
                }
            }
        })
        
        return false
    }
    
    // 处理 Universal Link(通用链接)
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let resultWeChat = WXPayTools.sharedInstance.handleOpen(universalLink: userActivity)
        if resultWeChat {
            return resultWeChat
        }
        return false
    }
    
    // 处理 deprecated 接口
    @available(iOS, deprecated: 9.0)
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let resultWeChat = WXPayTools.sharedInstance.handleOpen(url: url)
        if resultWeChat {
            return resultWeChat
        }
        
        if url.host == "safepay" {
            // 跳转支付宝客户端进行支付，处理支付结果
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: nil)
        }
        
        return true
    }
    
    
    
}



class WXPayTools: NSObject, WXApiDelegate {
    
    static let sharedInstance = WXPayTools()
    
    var authSuccessBlock: ((String) -> Void)?
    var paySuccessBlock: (() -> Void)?
    var payFailedBlock: (() -> Void)?
    var wxLoginSuccessBlock: (() -> Void)?
    var wxLoginFailedBlock: (() -> Void)?
    
    private override init() {
        super.init()
    }
    
    // 回调
    func handleOpen(url: URL) -> Bool {
        if url.absoluteString.contains("\("wxfbe855af004db917")://pay/") {
            return WXApi.handleOpen(url, delegate: self)
        } else {
            return WXApi.handleOpen(url, delegate: self)
        }
    }
    
    // 回调 Universal Link(通用链接)
    func handleOpen(universalLink userActivity: NSUserActivity) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }
    
    // 微信支付
    func doWXPay(dataDict: [String: Any], paySuccess: @escaping () -> Void, payFailed: @escaping () -> Void) {
        self.paySuccessBlock = paySuccess
        self.payFailedBlock = payFailed
        
        if let request = createPayReq(from: dataDict) {
            WXApi.send(request) { success in
                // 处理发送结果
            }
        }
    }
    
    // 创建支付请求
    private func createPayReq(from dataDict: [String: Any]) -> PayReq? {
        guard
            let partnerId = dataDict["partnerId"] as? String,
            let prepayId = dataDict["prepayId"] as? String,
            let nonceStr = dataDict["nonceStr"] as? String,
            let timeStamp = dataDict["timeStamp"] as? UInt32,
            let sign = dataDict["sign"] as? String
        else { return nil }
        
        let request = PayReq()
        request.partnerId = partnerId
        request.prepayId = prepayId
        request.package = "Sign=WXPay"
        request.nonceStr = nonceStr
        request.timeStamp = timeStamp
        request.sign = sign
        return request
    }
    
    // Delegate 回调方法
    func onResp(_ resp: BaseResp) {
        if let response = resp as? PayResp {
            switch response.errCode {
            case WXSuccess.rawValue:
                paySuccessBlock?()
            default:
                payFailedBlock?()
            }
        } else if let sendAuth = resp as? SendAuthResp {
            switch sendAuth.errCode {
            case WXSuccess.rawValue:
                if let code = sendAuth.code {
                    doWXLogin(code: code)
                }
            default:
                wxLoginFailedBlock?()
            }
        }
    }
    
    private func doWXLogin(code: String) {
        /*NetworkService<AuthAPI,TokenResponse>().request(.wxLogin(code: code)) { result in
            switch result{
            case .success(let response):
                TokenManager.shared.accessToken = response?.accessToken
                TokenManager.shared.accessTokenExpiration = response?.accessTokenExpiration
                TokenManager.shared.refreshToken = response?.refreshToken
                TokenManager.shared.refreshTokenExpiration = response?.refreshTokenExpiration
                AccountManager.shared.phoneNum = code
                let mainController = MainTabBarController()
                mainController.modalPresentationStyle = .fullScreen
                UIViewController.ex_keyWindow()?.rootViewController = mainController
                
            case .failure(let error):
                UIViewController.ex_keyWindow()?.showWindowError(withStatus: error.localizedDescription)
                
                
            }
        }             */

    }
}
