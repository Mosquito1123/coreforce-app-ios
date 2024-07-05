//
//  BatteryOfflineView.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit

class BatteryOfflineView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: "您的电池已离线，请前往附近电柜及时更换电池")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(rgba:0xFF4D4FFF) ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgba:0xFFEBE9FF)
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
      
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
        blurView.layer.cornerRadius = 8
        blurView.layer.masksToBounds = true
        
    }

}

// MARK: - Setup
private extension BatteryOfflineView {
    
    private func setupSubviews() {
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -14),
            
        ])
    }
    
}

// MARK: - Public
extension BatteryOfflineView {
    
}

// MARK: - Action
@objc private extension BatteryOfflineView {
    
}

// MARK: - Private
private extension BatteryOfflineView {
    
}
