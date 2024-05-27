//
//  LoginAccountInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginAccountInputView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phone_input")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var phoneNumberTextField :UITextField = {
        let textField = UITextField()
        // 手机号码输入框
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"333333") ?? UIColor.black]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入您的手机号码", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"A0A0A0") ?? UIColor.black])
        textField.delegate = self
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
private extension LoginAccountInputView {
    
    private func setupSubviews() {
        addSubview(logoView)
        addSubview(phoneNumberTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: phoneNumberTextField.leadingAnchor, constant: -14),
            logoView.widthAnchor.constraint(equalToConstant: 18),
            logoView.heightAnchor.constraint(equalToConstant: 18),
            phoneNumberTextField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            
        ])
    }
    
}

// MARK: - Public
extension LoginAccountInputView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(named: "3171EF")?.cgColor
        self.layer.borderWidth = 1.5
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0

    }
}

// MARK: - Action
@objc private extension LoginAccountInputView {
    
}

// MARK: - Private
private extension LoginAccountInputView {
    
}
