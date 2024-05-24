//
//  LoginVCodeInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginVCodeInputView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "v_code_input")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var vCodeTextField :UITextField = {
        let textField = UITextField()
        // 手机号码输入框
        textField.placeholder = "请输入验证码"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
private extension LoginVCodeInputView {
    
    private func setupSubviews() {
        addSubview(logoView)
        addSubview(vCodeTextField)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: vCodeTextField.leadingAnchor, constant: -14),
            logoView.widthAnchor.constraint(equalToConstant: 20),
            logoView.heightAnchor.constraint(equalToConstant: 20),
            vCodeTextField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            vCodeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            
        ])
    }
    
}

// MARK: - Public
extension LoginVCodeInputView {
    
}

// MARK: - Action
@objc private extension LoginVCodeInputView {
    
}

// MARK: - Private
private extension LoginVCodeInputView {
    
}
