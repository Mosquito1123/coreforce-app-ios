//
//  PersonalViewBackgroundView.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalViewBackgroundView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.92, green: 0.96, blue: 1, alpha: 1).cgColor, UIColor(red: 0.95, green: 0.94, blue: 0.97, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = self.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(bgLayer1, at: 0)
        let imageLayer = CALayer()
        guard let image = UIImage(named: "corner_bg") else { return }
        imageLayer.contents = image.cgImage
        imageLayer.frame = CGRect(x: bounds.width - image.size.width - 22.5, y: 30, width: image.size.width, height: image.size.height)
        layer.addSublayer(imageLayer)
    }
}

// MARK: - Setup
private extension PersonalViewBackgroundView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension PersonalViewBackgroundView {
    
}

// MARK: - Action
@objc private extension PersonalViewBackgroundView {
    
}

// MARK: - Private
private extension PersonalViewBackgroundView {
    
}
