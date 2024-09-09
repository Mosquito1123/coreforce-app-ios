//
//  ChangePasswordViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/13.
//

import UIKit

class ChangePasswordViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    private var oldPasswordInputView: LoginPasswordInputView!
        private var passwordInputView: LoginPasswordInputView!
        private var confirmPasswordInputView: LoginPasswordInputView!
        private var headerBackgroundView: UIImageView!
        private var titleLabel: UILabel!
        private var subtitleLabel: UILabel!
        private var submitButton: UIButton!
        private var forgetPasswordButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupNavbar()
            setupSubviews()
            setupLayout()
            
            NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: oldPasswordInputView.passwordTextField)
            NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: passwordInputView.passwordTextField)
            NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: confirmPasswordInputView.passwordTextField)
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        // MARK: - Setup
        
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
            view.backgroundColor = .white
            
            headerBackgroundView = UIImageView()
            headerBackgroundView.image = UIImage(named: "change_password_background")
            headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(headerBackgroundView)
            
            titleLabel = UILabel()
            titleLabel.text = "修改密码"
            titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .medium)
            titleLabel.textColor = UIColor(rgba: 0x333333FF)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
            
            subtitleLabel = UILabel()
            subtitleLabel.text = "密码必须6-16位数字和字母组合，如未设置过密码可不输入旧密码"
            subtitleLabel.font = UIFont.systemFont(ofSize: 14)
            subtitleLabel.textColor = UIColor(rgba: 0x4D4D4DFF)
            subtitleLabel.numberOfLines = 0
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subtitleLabel)
            
            oldPasswordInputView = LoginPasswordInputView()
            oldPasswordInputView.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
            oldPasswordInputView.placeholder = "请输入旧密码"
            oldPasswordInputView.logoView.isHidden = true
            oldPasswordInputView.passwordTextFieldLeading.constant = 20
            oldPasswordInputView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(oldPasswordInputView)
            
            passwordInputView = LoginPasswordInputView()
            passwordInputView.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
            passwordInputView.placeholder = "请设置新密码"
            passwordInputView.logoView.isHidden = true
            passwordInputView.passwordTextFieldLeading.constant = 20
            passwordInputView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(passwordInputView)
            
            confirmPasswordInputView = LoginPasswordInputView()
            confirmPasswordInputView.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
            confirmPasswordInputView.placeholder = "请再次输入新密码"
            confirmPasswordInputView.logoView.isHidden = true
            confirmPasswordInputView.passwordTextFieldLeading.constant = 20
            confirmPasswordInputView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(confirmPasswordInputView)
            
            submitButton = UIButton(type: .custom)
            submitButton.setTitle("确认修改", for: .normal)
            submitButton.setTitleColor(.white, for: .normal)
            let imageEnabled = UIColor(rgba: 0x447AFEFF).toImage(size: CGSize(width: 1, height: 1))
            let imageDisabled = UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.2).toImage(size: CGSize(width: 1, height: 1))
            submitButton.setBackgroundImage(imageEnabled, for: .normal)
            submitButton.setBackgroundImage(imageDisabled, for: .disabled)
            submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            submitButton.layer.cornerRadius = 25
            submitButton.layer.masksToBounds = true
            submitButton.isEnabled = false
            submitButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
            submitButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(submitButton)
            
            forgetPasswordButton = UIButton(type: .custom)
            forgetPasswordButton.setTitle("忘记密码", for: .normal)
            forgetPasswordButton.setTitleColor(UIColor(rgba: 0x797979FF), for: .normal)
            forgetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            forgetPasswordButton.addTarget(self, action: #selector(goToForgetPassword), for: .touchUpInside)
            forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(forgetPasswordButton)
        }
        
        private func setupLayout() {
            NSLayoutConstraint.activate([
                headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36.5),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12),
                
                subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
                subtitleLabel.bottomAnchor.constraint(equalTo: oldPasswordInputView.topAnchor, constant: -34),
                
                oldPasswordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                oldPasswordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
                oldPasswordInputView.heightAnchor.constraint(equalToConstant: 50),
                oldPasswordInputView.bottomAnchor.constraint(equalTo: passwordInputView.topAnchor, constant: -12),
                
                passwordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                passwordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
                passwordInputView.heightAnchor.constraint(equalToConstant: 50),
                passwordInputView.bottomAnchor.constraint(equalTo: confirmPasswordInputView.topAnchor, constant: -12),
                
                confirmPasswordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                confirmPasswordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
                confirmPasswordInputView.heightAnchor.constraint(equalToConstant: 50),
                confirmPasswordInputView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -97.5),
                
                submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
                submitButton.heightAnchor.constraint(equalToConstant: 50),
                submitButton.bottomAnchor.constraint(equalTo: forgetPasswordButton.topAnchor, constant: -20),
                
                forgetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
        
        // MARK: - Actions
        
        @objc private func submit(_ sender: UIButton) {
            let oldPasswordMD5 = oldPasswordInputView.passwordTextField.text?.md5 ?? ""
            let confirmPasswordMD5 = confirmPasswordInputView.passwordTextField.text?.md5 ?? ""
            self.postData(changePwdUrl, param: ["oldPwd": oldPasswordMD5, "newPwd": confirmPasswordMD5], isLoading: true) { responseObject in
                self.showSuccess(withStatus: "密码修改成功")
                self.navigationController?.popViewController(animated: true)
            } error: { error in
                self.showError(withStatus:error.localizedDescription)

            }

            
        }
        
        @objc private func goToForgetPassword(_ sender: UIButton) {
            let forgetPasswordViewController = ForgetPasswordViewController()
            navigationController?.pushViewController(forgetPasswordViewController, animated: true)
        }
        
        @objc private func updateButtonState() {
            let isOldPasswordEmpty = oldPasswordInputView.passwordTextField.text?.isEmpty ?? true
            let isPasswordEmpty = passwordInputView.passwordTextField.text?.isEmpty ?? true
            let isConfirmPasswordEmpty = confirmPasswordInputView.passwordTextField.text?.isEmpty ?? true
            
            submitButton.isEnabled = !isOldPasswordEmpty && !isPasswordEmpty && !isConfirmPasswordEmpty
        }
}

// MARK: - Setup
private extension ChangePasswordViewController {
    
    
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
    
}

// MARK: - Private
private extension ChangePasswordViewController {
    
}
