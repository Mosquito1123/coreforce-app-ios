//
//  LoginPasswordInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginPasswordInputView: UIView {

    // MARK: - Accessor
    var placeholder:String?{
        didSet{
            passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0xA0A0A0FF)])
        }
    }
    var passwordTextFieldLeading:NSLayoutConstraint!
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
        button.addTarget(self, action: #selector(eyeToggle(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var passwordTextField :UITextField = {
        let textField = UITextField()
        // 密码输入框
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0x333333FF)]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0xA0A0A0FF)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex:0xF5F7FBFF)
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
        self.passwordTextFieldLeading = passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20+18+14)
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.widthAnchor.constraint(equalToConstant: 18),
            logoView.heightAnchor.constraint(equalToConstant: 18),
            self.passwordTextFieldLeading,
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
extension LoginPasswordInputView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(hex:0x3171EFFF).cgColor
        self.layer.borderWidth = 1.5
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0

    }
}

// MARK: - Action
@objc private extension LoginPasswordInputView {
    @objc func eyeToggle(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
}

// MARK: - Private
private extension LoginPasswordInputView{
    
}
