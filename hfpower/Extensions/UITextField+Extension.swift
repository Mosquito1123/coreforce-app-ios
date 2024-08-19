//
//  UITextField+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/8/16.
//

import UIKit
extension UITextField {
    private class TextFieldActionClosureWrapper: NSObject {
        var closure: ((String?) -> Void)
        
        init(_ closure: @escaping ((String?) -> Void)) {
            self.closure = closure
        }
        
        @objc func invoke(_ textField: UITextField) {
            closure(textField.text)
        }
    }
    
    func addTextChangedAction(_ action: @escaping (String?) -> Void) {
        let wrapper = TextFieldActionClosureWrapper(action)
        addTarget(wrapper, action: #selector(wrapper.invoke(_:)), for: .editingChanged)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
