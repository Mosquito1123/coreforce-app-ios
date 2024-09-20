//
//  ForgetPasswordVPhoneNumberViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class ForgetPasswordVPhoneNumberViewController: UIViewController {
    
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
        label.text = "手机号验证"
        label.font = UIFont.systemFont(ofSize: 26,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "当前手机号：132****1234"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var vCodeInputView:LoginVCodeInputView = {
        let view = LoginVCodeInputView()
        view.controller = self
        view.backgroundColor = UIColor(hex:0xF5F7FBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var submitButton : UIButton = {
        let button = UIButton(type: .custom)
        // 登录按钮
        button.tintAdjustmentMode = .automatic
        button.setTitle("下一步，设置新密码", for: .normal)
        button.setTitle("下一步，设置新密码", for: .highlighted)
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.vCodeInputView.vCodeTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.submitButton.isEnabled = !(self.vCodeInputView.vCodeTextField.text?.isEmpty ?? true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

// MARK: - Setup
private extension ForgetPasswordVPhoneNumberViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.vCodeInputView)
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
            subtitleLabel.bottomAnchor.constraint(equalTo: vCodeInputView.topAnchor, constant: -34),
            vCodeInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            vCodeInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            vCodeInputView.heightAnchor.constraint(equalToConstant: 50),
            vCodeInputView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -241),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            submitButton.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
}

// MARK: - Public
extension ForgetPasswordVPhoneNumberViewController {
    
}

// MARK: - Request
private extension ForgetPasswordVPhoneNumberViewController {
    
}

// MARK: - Action
@objc private extension ForgetPasswordVPhoneNumberViewController {
    @objc func back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func next(_ sender:UIButton){
        let forgetPasswordViewController = ForgetPasswordViewController()
        self.navigationController?.pushViewController(forgetPasswordViewController, animated: true)
    }
}

// MARK: - Private
private extension ForgetPasswordVPhoneNumberViewController {
    
}
