//
//  UIResponder+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit
import SVProgressHUD
extension UIResponder{
    public func showInfo(withStatus status:String?){
        DispatchQueue.main.async {
            SVProgressHUD.showInfo(withStatus: status)

        }
    }
    public func showError(withStatus status:String?){
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: status)

        }
    }
    public func showSuccess(withStatus status:String?){
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: status)

        }
    }
}
