//
//  LoginInviteInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginInviteCodeInputView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "invite_input")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var inviteCodeTextField :UITextField = {
        let textField = UITextField()
        // 手机号码输入框
//        textField.placeholder = "请输入邀请码（选填）"
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"333333") ?? UIColor.black]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入邀请码（选填）", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"A0A0A0") ?? UIColor.black])
        textField.returnKeyType = .done
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
private extension LoginInviteCodeInputView {
    
    private func setupSubviews() {
        addSubview(logoView)
        addSubview(inviteCodeTextField)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: inviteCodeTextField.leadingAnchor, constant: -14),
            logoView.widthAnchor.constraint(equalToConstant: 18),
            logoView.heightAnchor.constraint(equalToConstant: 18),
            inviteCodeTextField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            inviteCodeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            
        ])
    }
    
}

// MARK: - Public
extension LoginInviteCodeInputView:UITextFieldDelegate {
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
@objc private extension LoginInviteCodeInputView {
    
}

// MARK: - Private
private extension LoginInviteCodeInputView {
    
}
