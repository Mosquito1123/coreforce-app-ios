//
//  OrderDetailFooterView.swift
//  hfpower
//
//  Created by EDY on 2024/8/19.
//

import UIKit

class OrderDetailFooterView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "客服电话："
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("400-6789-509", for: .normal)
        button.setTitle("400-6789-509", for: .highlighted)

        button.setTitleColor(UIColor(hex:0x447AFEFF), for: .normal)
        button.setTitleColor(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5), for: .highlighted)
       
        button.addAction(for: .touchUpInside) {
            if let phoneURL = URL(string: "tel://400-6789-509"), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension OrderDetailFooterView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0xF6F6F6FF)
        self.addSubview(self.contactLabel)
        self.addSubview(self.phoneNumberButton)
        phoneNumberButton.sizeToFit()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            contactLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 32),
            contactLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: -4*15),
            phoneNumberButton.centerYAnchor.constraint(equalTo: self.contactLabel.centerYAnchor),
            phoneNumberButton.leadingAnchor.constraint(equalTo: contactLabel.trailingAnchor,constant: 5.5),
            
            
        
        ])
    }
    
}

// MARK: - Public
extension OrderDetailFooterView {
    
}

// MARK: - Action
@objc private extension OrderDetailFooterView {
    
}

// MARK: - Private
private extension OrderDetailFooterView {
    
}
