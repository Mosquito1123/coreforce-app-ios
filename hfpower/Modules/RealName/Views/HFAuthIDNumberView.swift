//
//  HFAuthIDNumberView.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit

class HFAuthIDNumberView: UIView {
    
    // MARK: - Properties
    
   
    
    private(set) lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "请输入您的身份证号"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var numberBlock: ((UITextField) -> Void)?
    
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
        numberBlock?(textField)
    }
}


// MARK: - Setup
private extension HFAuthIDNumberView {
    
    // MARK: - Setup
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex: 0xF5F7FBFF)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        addSubview(numberTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            numberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            numberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            numberTextField.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            numberTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
        ])
    }
    
    
}

// MARK: - Public
extension HFAuthIDNumberView {
    
}

// MARK: - Action
@objc private extension HFAuthIDNumberView {
    
}

// MARK: - Private
private extension HFAuthIDNumberView {
    
}
