//
//  HFAuthNameView.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit

class HFAuthNameView: UIView {
    
    // MARK: - Properties
    
    
    private(set) lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "请输入您的真实姓名"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var nameBlock: ((UITextField) -> Void)?
    
    // MARK: - Initializers
    
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
    
    
    
    // MARK: - Actions
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        nameBlock?(textField)
    }
}


// MARK: - Setup
private extension HFAuthNameView {
    
    // MARK: - Setup
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex: 0xF5F7FBFF)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        addSubview(nameTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
        ])
    }
    
}

// MARK: - Public
extension HFAuthNameView {
    
}

// MARK: - Action
@objc private extension HFAuthNameView {
    
}

// MARK: - Private
private extension HFAuthNameView {
    
}
