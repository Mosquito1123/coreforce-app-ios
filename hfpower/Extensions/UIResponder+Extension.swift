//
//  UIResponder+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit
import SVProgressHUD
extension UIResponder{
    public func showWindowInfo(withStatus status:String?){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaxSupportedWindowLevel(.statusBar)
        let keyWindow : UIWindow? = {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
                    .compactMap { $0 as? UIWindowScene }.first?.windows
                    .filter { $0.isKeyWindow }.first;
            }else {
                return UIApplication.shared.keyWindow!
            }
        }()
        
        SVProgressHUD.setContainerView(keyWindow)
        SVProgressHUD.showInfo(withStatus: status)
        
        
    }
    public func showWindowError(withStatus status:String?){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaxSupportedWindowLevel(.statusBar)
        let keyWindow : UIWindow? = {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
                    .compactMap { $0 as? UIWindowScene }.first?.windows
                    .filter { $0.isKeyWindow }.first;
            }else {
                return UIApplication.shared.keyWindow!
            }
        }()
        
        SVProgressHUD.setContainerView(keyWindow)
        SVProgressHUD.showError(withStatus: status)
        
        
    }
    public func showWindowSuccess(withStatus status:String?){            SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaxSupportedWindowLevel(.statusBar)
        let keyWindow : UIWindow? = {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }
                    .compactMap { $0 as? UIWindowScene }.first?.windows
                    .filter { $0.isKeyWindow }.first;
            }else {
                return UIApplication.shared.keyWindow!
            }
        }()
        
        SVProgressHUD.setContainerView(keyWindow)
        SVProgressHUD.showSuccess(withStatus: status)
        
    }
    public func showInfo(withStatus status:String?){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showInfo(withStatus: status)
        
        
    }
    public func showError(withStatus status:String?){
        SVProgressHUD.setDefaultStyle(.dark)
        
        SVProgressHUD.showError(withStatus: status)
        
        
    }
    public func showSuccess(withStatus status:String?){            SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showSuccess(withStatus: status)
        
    }
}
