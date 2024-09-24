//
//  ChangePhoneNumberViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class ChangePhoneNumberViewController: UIViewController,UIGestureRecognizerDelegate {
    
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
        label.text = "设置新手机号"
        label.font = UIFont.systemFont(ofSize: 26,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入新的可用的手机号"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.accountInputView.phoneNumberTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.vCodeInputView.vCodeTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.vCodeInputView.phoneNum = self.accountInputView.phoneNumberTextField.text
        self.submitButton.isEnabled = !(self.accountInputView.phoneNumberTextField.text?.isEmpty ?? true) && !(self.vCodeInputView.vCodeTextField.text?.isEmpty ?? true)
    }
    
    
    
}

// MARK: - Setup
private extension ChangePhoneNumberViewController {
    
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
            vCodeInputView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -97.5),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            submitButton.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
}

// MARK: - Public
extension ChangePhoneNumberViewController {
    
}

// MARK: - Request
private extension ChangePhoneNumberViewController {
    
}

// MARK: - Action
@objc private extension ChangePhoneNumberViewController {
    @objc func back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func next(_ sender:UIButton){

        let vCode = vCodeInputView.vCodeTextField.text ?? ""

        postData(memberBindUrl, param: ["pinCode": vCode], isLoading: true, success: { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any], body["reLogin"] as? Int == 1 {
                self.postData(logoutUrl, param: [:], isLoading: true, success: { responseObject in
                    let homePageVC = LoginViewController()
                    UIViewController.ex_keyWindow()?.rootViewController = UINavigationController(rootViewController: homePageVC)
                    HFKeyedArchiverTool.removeData()
                    AccountManager.shared.clearAccount()
                    self.showWindowSuccess(withStatus: "手机号绑定成功，请重新登录")
                }, error: { error in
                    self.showError(withStatus: error.localizedDescription)
                })
            }
            
            if let head = (responseObject as? [String: Any])?["head"] as? [String: Any], head["retFlag"] as? String == "00000" {
                self.navigationController?.popViewController(animated: true)
            }
        }, error: { error in
            self.showError(withStatus: error.localizedDescription)
        })

    }
}

// MARK: - Private
private extension ChangePhoneNumberViewController {
    
}
