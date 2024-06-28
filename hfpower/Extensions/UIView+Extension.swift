//
//  UIView+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit
extension UILabel {
    func applyGlobalTextStyle() {
        let font = self.font ?? UIFont.preferredFont(forTextStyle: .body)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledFont = fontMetrics.scaledFont(for: font)
        self.font = scaledFont
        self.adjustsFontForContentSizeCategory = true
    }
}
 
extension UIButton {
    func applyGlobalTextStyle() {
        let font =  self.titleLabel?.font ?? UIFont.preferredFont(forTextStyle: .body)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledFont = fontMetrics.scaledFont(for: font)
        self.titleLabel?.font = scaledFont
        self.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}
 
extension UITextField {
    func applyGlobalTextStyle() {
        let font = self.font ?? UIFont.preferredFont(forTextStyle: .body)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledFont = fontMetrics.scaledFont(for: font)
        self.font = scaledFont
        self.adjustsFontForContentSizeCategory = true
    }
}
 
 
extension UITextView {
    func applyGlobalTextStyle() {
        let font = self.font ?? UIFont.preferredFont(forTextStyle: .body)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledFont = fontMetrics.scaledFont(for: font)
        self.font = scaledFont
        self.adjustsFontForContentSizeCategory = true
    }
}
