//
//  ForgetPasswordViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/13.
//

import UIKit

class ForgetPasswordViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
   
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
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "密码必须6-16位数字和字母组合"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var newPasswordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(hex:0xF5F7FBFF)
        view.placeholder = "请设置新密码"
        view.logoView.isHidden = true
        view.passwordTextFieldLeading.constant = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var accountInputView:LoginAccountInputView = {
        let view = LoginAccountInputView()
        view.backgroundColor = UIColor(hex:0xF5F7FBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var vCodeInputView:LoginVCodeInputView = {
        let view = LoginVCodeInputView()
        view.controller = self
        view.backgroundColor = UIColor(hex:0xF5F7FBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var confirmPasswordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.backgroundColor = UIColor(hex:0xF5F7FBFF)
        view.placeholder = "请再次输入新密码"
        view.logoView.isHidden = true
        view.passwordTextFieldLeading.constant = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var submitButton : UIButton = {
        let button = UIButton(type: .custom)
        // 登录按钮
        button.tintAdjustmentMode = .automatic
        button.setTitle("确认修改", for: .normal)
        button.setTitle("确认修改", for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        let imageEnabled = UIColor(hex:0x447AFEFF).toImage()
        let imageDisabled =  UIColor(hex:0x447AFEFF).withAlphaComponent(0.2).toImage()
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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.accountInputView.phoneNumberTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.vCodeInputView.vCodeTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.newPasswordInputView.passwordTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.confirmPasswordInputView.passwordTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.vCodeInputView.phoneNum = self.accountInputView.phoneNumberTextField.text
        self.submitButton.isEnabled = !(self.accountInputView.phoneNumberTextField.text?.isEmpty ?? true) && !(self.vCodeInputView.vCodeTextField.text?.isEmpty ?? true) && !(self.newPasswordInputView.passwordTextField.text?.isEmpty ?? true) && !(self.confirmPasswordInputView.passwordTextField.text?.isEmpty ?? true)
    }
    
}

// MARK: - Setup
private extension ForgetPasswordViewController {
    
    private func setupNavbar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)
        backButton.setTitle("", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
            
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.accountInputView)
        self.view.addSubview(self.vCodeInputView)
        self.view.addSubview(self.newPasswordInputView)
        self.view.addSubview(confirmPasswordInputView)
        self.view.addSubview(self.submitButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            subtitleLabel.bottomAnchor.constraint(equalTo: accountInputView.topAnchor, constant: -34),
            accountInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            accountInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            accountInputView.heightAnchor.constraint(equalToConstant: 50),
            accountInputView.bottomAnchor.constraint(equalTo: vCodeInputView.topAnchor, constant: -12),
            vCodeInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            vCodeInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            vCodeInputView.heightAnchor.constraint(equalToConstant: 50),
            vCodeInputView.bottomAnchor.constraint(equalTo: newPasswordInputView.topAnchor, constant: -12),
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
            
            
        ])
   
        
    }
}

// MARK: - Public
extension ForgetPasswordViewController {
    
}

// MARK: - Request
private extension ForgetPasswordViewController {
    
}

// MARK: - Action
@objc private extension ForgetPasswordViewController {
    @objc func back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func submit(_ sender:UIButton){
        let account = accountInputView.phoneNumberTextField.text ?? ""
        let vCode = vCodeInputView.vCodeTextField.text ?? ""
        let confirmPasswordMD5 = confirmPasswordInputView.passwordTextField.text?.md5 ?? ""

        self.postData(forgetPwdUrl, param: ["account": account, "smsCode": vCode, "pwd": confirmPasswordMD5], isLoading: true, success: { responseObject in
            if let head = (responseObject  as? [String: Any])?["head"] as? [String: Any], let retMsg = head["retMsg"] as? String, retMsg == "成功" {
                self.showSuccess(withStatus: "密码修改成功")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }, error: { error in
            self.showToastMessage(error.localizedDescription)
        })

    }
}

// MARK: - Private
private extension ForgetPasswordViewController {
    
}
