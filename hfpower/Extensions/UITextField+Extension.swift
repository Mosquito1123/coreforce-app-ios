//
//  UITextField+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/8/16.
//

import UIKit
extension UITextField {
    typealias TextFieldAction = (String) -> Void
    
    private struct AssociatedKeys {
        static var actionHandler = "actionHandler"
    }
    
    var action: TextFieldAction? {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.actionHandler) as? TextFieldAction
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.actionHandler, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    func addAction(_ action: @escaping TextFieldAction) {
        self.action = action
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        action?(text ?? "")
    }
}
