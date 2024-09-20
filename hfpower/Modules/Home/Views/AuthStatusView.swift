//
//  AuthStatusView.swift
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

import UIKit
private let kCornerRadius: CGFloat = 16.0
private let kHorizontalPadding: CGFloat = 16.0
private let kVerticalPadding: CGFloat = 8.0
class AuthStatusView: UIView {
    
    // MARK: - Accessor
    var buttonTapHandler: (() -> Void)?
    // MARK: - Subviews
    // MARK: - Properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.text = "您还未实名认证"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("立即认证", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(size: CGSize(width: 90, height: 24)), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
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
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension AuthStatusView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = kCornerRadius
        self.layer.masksToBounds = true
        addSubview(titleLabel)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        addSubview(actionButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Label constraints
            self.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -kHorizontalPadding),
            self.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -kVerticalPadding),
            self.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: kVerticalPadding),
            
            // Button constraints
            self.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: kHorizontalPadding),
            
            // Horizontal spacing between label and button
            titleLabel.leadingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -8.0),
            
            // Vertical alignment for label and button
            titleLabel.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor)
        ])
    }
    
}

// MARK: - Public
extension AuthStatusView {
    
}

// MARK: - Action
@objc private extension AuthStatusView {
    @objc private func buttonTapped() {
        buttonTapHandler?()
    }
}

// MARK: - Private
private extension AuthStatusView {
    
}
