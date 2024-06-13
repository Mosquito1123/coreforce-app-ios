//
//  HFAuthNameView.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit

import UIKit

class HFAuthNameView: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "真实姓名"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .right
        textField.placeholder = "请输入"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var nameBlock: ((UITextField) -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
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
        addSubview(titleLabel)
        addSubview(nameTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -14),
            
            nameTextField.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            nameTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
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
