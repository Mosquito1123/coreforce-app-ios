//
//  ChangePasswordViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/13.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var backButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var oldPasswordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
        view.placeholder = "请输入旧密码"
        view.logoView.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var newPasswordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
        view.placeholder = "请设置新密码"
        view.logoView.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var confirmPasswordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
        view.placeholder = "请再次输入新密码"
        view.logoView.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var headerBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "change_password_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "修改密码"
        label.font = UIFont.systemFont(ofSize: 26,weight: .medium)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "密码必须6-16位数字和字母组合，如未设置过密码可不输入旧密码"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var submitButton : UIButton = {
        let button = UIButton(type: .custom)
        // 登录按钮
        button.tintAdjustmentMode = .automatic
        button.setTitle("确认修改", for: .normal)
        button.setTitle("确认修改", for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        let imageEnabled = UIColor(rgba:0x447AFEFF).toImage()
        let imageDisabled =  UIColor(rgba:0x447AFEFF).withAlphaComponent(0.2).toImage()
        button.setBackgroundImage(imageEnabled, for: .normal)
        button.setBackgroundImage(imageDisabled, for: .disabled)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        
        return button
    }()
    lazy var forgetPasswordButton :UIButton = {
        let button = UIButton(type: .custom)

        // 验证码登录按钮
        button.setTitle("忘记密码", for: .normal)
        button.setTitleColor(UIColor(rgba:0x797979FF), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(goToForgetPassword(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.oldPasswordInputView.passwordTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.newPasswordInputView.passwordTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.confirmPasswordInputView.passwordTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.submitButton.isEnabled = !(self.oldPasswordInputView.passwordTextField.text?.isEmpty ?? true) && !(self.newPasswordInputView.passwordTextField.text?.isEmpty ?? true) && !(self.confirmPasswordInputView.passwordTextField.text?.isEmpty ?? true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
private extension ChangePasswordViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(oldPasswordInputView)
        oldPasswordInputView.passwordTextFieldLeading.constant = 20
        self.view.addSubview(newPasswordInputView)
        newPasswordInputView.passwordTextFieldLeading.constant = 20
        self.view.addSubview(confirmPasswordInputView)
        confirmPasswordInputView.passwordTextFieldLeading.constant = 20
        self.view.addSubview(self.submitButton)
        self.view.addSubview(self.forgetPasswordButton)
        self.view.bringSubviewToFront(self.backButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12.5),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 14.5),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -36.5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            subtitleLabel.bottomAnchor.constraint(equalTo: oldPasswordInputView.topAnchor, constant: -34),
            oldPasswordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            oldPasswordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            oldPasswordInputView.heightAnchor.constraint(equalToConstant: 50),
            oldPasswordInputView.bottomAnchor.constraint(equalTo: newPasswordInputView.topAnchor, constant: -12),
            newPasswordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            newPasswordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            newPasswordInputView.heightAnchor.constraint(equalToConstant: 50),
            newPasswordInputView.bottomAnchor.constraint(equalTo: confirmPasswordInputView.topAnchor, constant: -12),
            confirmPasswordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            confirmPasswordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            confirmPasswordInputView.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordInputView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -97.5),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.bottomAnchor.constraint(equalTo: forgetPasswordButton.topAnchor, constant: -20),
            forgetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),


        ])
    }
}

// MARK: - Public
extension ChangePasswordViewController {
    
}

// MARK: - Request
private extension ChangePasswordViewController {
    
}

// MARK: - Action
@objc private extension ChangePasswordViewController {
    @objc func back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func submit(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func goToForgetPassword(_ sender:UIButton){
        let forgetPasswordVPhoneNumberViewController = ForgetPasswordVPhoneNumberViewController()
        self.navigationController?.pushViewController(forgetPasswordVPhoneNumberViewController, animated: true)
    }
}

// MARK: - Private
private extension ChangePasswordViewController {
    
}
