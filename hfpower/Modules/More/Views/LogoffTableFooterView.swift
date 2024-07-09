//
//  LogoffTableFooterView.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogoffTableFooterView: UIView {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var groupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "温馨提示"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "如有问题，请联系客服热线"
        label.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("400-6789-509", for: .normal)
        button.setTitle("400-6789-509", for: .highlighted)

        button.setTitleColor(UIColor(red: 68/255, green: 122/255, blue: 254/255, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(red: 68/255, green: 122/255, blue: 254/255, alpha: 1.0), for: .highlighted)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(phoneNumberTapped(_:)), for: .touchUpInside)
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
        super.init(coder:coder)
    }
    
}

// MARK: - Setup
private extension LogoffTableFooterView {
    
    private func setupSubviews() {
        backgroundColor = .white
        addSubview(groupView)
        
        groupView.addSubview(tipLabel)
        groupView.addSubview(contactLabel)
        groupView.addSubview(phoneNumberButton)
        
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Group View Constraints
            groupView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            groupView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            groupView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40),
            
            // Tip Label Constraints
            tipLabel.leadingAnchor.constraint(equalTo: groupView.leadingAnchor, constant: 16),
            tipLabel.topAnchor.constraint(equalTo: groupView.topAnchor, constant: 14),
            
            // Contact Label Constraints
            contactLabel.leadingAnchor.constraint(equalTo: groupView.leadingAnchor, constant: 16),
            contactLabel.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 11),
            contactLabel.bottomAnchor.constraint(equalTo: self.groupView.bottomAnchor, constant: -14),
            // Phone Number Button Constraints
            phoneNumberButton.leadingAnchor.constraint(equalTo: contactLabel.trailingAnchor, constant: 8),
            phoneNumberButton.centerYAnchor.constraint(equalTo: contactLabel.centerYAnchor),
            phoneNumberButton.trailingAnchor.constraint(equalTo: self.groupView.trailingAnchor,constant: -16),
        ])
    }
    
}

// MARK: - Public
extension LogoffTableFooterView {
    
}

// MARK: - Action
@objc private extension LogoffTableFooterView {
    @objc func phoneNumberTapped(_ sender:UIButton) {
        if let url = URL(string: "tel://4006789509") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Private
private extension LogoffTableFooterView {
    
}
