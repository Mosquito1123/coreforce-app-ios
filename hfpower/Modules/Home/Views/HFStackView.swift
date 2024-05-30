//
//  HFStackView.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit

class HFStackView: UIStackView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    

}

// MARK: - Setup
private extension HFStackView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension HFStackView {
    
}

// MARK: - Action
@objc private extension HFStackView {
    
}

// MARK: - Private
private extension HFStackView {
    
}
