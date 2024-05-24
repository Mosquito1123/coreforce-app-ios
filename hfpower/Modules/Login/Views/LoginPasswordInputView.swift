//
//  LoginPasswordInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginPasswordInputView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "password_input")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var toggleButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye_hide"), for: .normal)
        button.setImage(UIImage(named: "eye_show"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var passwordTextField :UITextField = {
        let textField = UITextField()
        // 密码输入框
        textField.placeholder = "请输入密码"
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "F5F7FB")
        self.layer.cornerRadius = 25

        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension LoginPasswordInputView {
    
    private func setupSubviews() {
        addSubview(logoView)
        addSubview(passwordTextField)
        addSubview(toggleButton)


    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: -14),
            logoView.widthAnchor.constraint(equalToConstant: 20),
            logoView.heightAnchor.constraint(equalToConstant: 20),

            passwordTextField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: toggleButton.leadingAnchor,constant: -20),
            toggleButton.centerYAnchor.constraint(equalTo:self.centerYAnchor),

            toggleButton.widthAnchor.constraint(equalToConstant: 20),
            toggleButton.heightAnchor.constraint(equalToConstant: 20),
            toggleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),

            
        ])
    }
    
}

// MARK: - Public
extension LoginPasswordInputView {
    
}

// MARK: - Action
@objc private extension LoginPasswordInputView {
    
}

// MARK: - Private
private extension LoginPasswordInputView {
    
}
