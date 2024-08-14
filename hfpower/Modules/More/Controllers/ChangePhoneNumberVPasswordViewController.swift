//
//  ChangePhoneNumberVPasswordViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class ChangePhoneNumberVPasswordViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var backButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var headerBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "change_password_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "密码验证"
        label.font = UIFont.systemFont(ofSize: 26,weight: .medium)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "当前手机号：132****1234"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var passwordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
        view.placeholder = "请输入账号密码"
        view.logoView.isHidden = true
        view.passwordTextFieldLeading.constant = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var submitButton : UIButton = {
        let button = UIButton(type: .custom)
        // 登录按钮
        button.tintAdjustmentMode = .automatic
        button.setTitle("下一步，设置新手机号", for: .normal)
        button.setTitle("下一步，设置新手机号", for: .highlighted)
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
        button.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.passwordInputView.passwordTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.submitButton.isEnabled = !(self.passwordInputView.passwordTextField.text?.isEmpty ?? true)
    }
    
}

// MARK: - Setup
private extension ChangePhoneNumberVPasswordViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.passwordInputView)
        self.view.addSubview(self.submitButton)
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
            subtitleLabel.bottomAnchor.constraint(equalTo: passwordInputView.topAnchor, constant: -34),
            passwordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            passwordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            passwordInputView.heightAnchor.constraint(equalToConstant: 50),
            passwordInputView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -241.5),
           
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            submitButton.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
}

// MARK: - Public
extension ChangePhoneNumberVPasswordViewController {
    
}

// MARK: - Request
private extension ChangePhoneNumberVPasswordViewController {
    
}

// MARK: - Action
@objc private extension ChangePhoneNumberVPasswordViewController {
    @objc func back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func next(_ sender:UIButton){
        let changePhoneNumberFinalController = ChangePhoneNumberFinalViewController()
        self.navigationController?.pushViewController(changePhoneNumberFinalController, animated: true)
    }
}

// MARK: - Private
private extension ChangePhoneNumberVPasswordViewController {
    
}
