//
//  LoginViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginViewController:UIViewController, UITextViewDelegate {
    // MARK: - Accessor
    
    // MARK: - Subviews
    // 懒加载微信登录按钮
    lazy var wechatLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "wechat"), for: .normal)
        button.setBackgroundImage(UIImage(named: "wechat"), for: .highlighted)
        button.tintAdjustmentMode = .automatic
        button.addTarget(self, action: #selector(wechatLoginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var loginBackgroundView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 其他配置...
        return imageView
    }()
    // 懒加载 HFLogo
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hflogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 其他配置...
        return imageView
    }()
    lazy var toggleButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "unselected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    // 懒加载 HFMark
    lazy var markImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hfmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 其他配置...
        return imageView
    }()
    lazy var accountInputView:LoginAccountInputView = {
        let view = LoginAccountInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var passwordInputView:LoginPasswordInputView = {
        let view = LoginPasswordInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .custom)
        // 登录按钮
        button.tintAdjustmentMode = .automatic
        button.setTitle("立即登录", for: .normal)
        button.setTitle("立即登录", for: .highlighted)
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
        button.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    lazy var verificationCodeButton :UIButton = {
        let button = UIButton(type: .custom)

        // 验证码登录按钮
        button.setTitle("切换验证码登录", for: .normal)
        button.setTitleColor(UIColor(hex:0x797979FF), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(goToPhoneLogin(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    // 懒加载 UITextView
    lazy var privacyPolicyAndUserAgreementTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        // 其他配置...
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()
    lazy var closeButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "close")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonState), name: UITextField.textDidChangeNotification, object: self.passwordInputView.passwordTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateButtonState() {
        self.loginButton.isEnabled = !(self.accountInputView.phoneNumberTextField.text?.isEmpty ?? true) && !(self.passwordInputView.passwordTextField.text?.isEmpty ?? true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleButton.isSelected = LoginModel.shared.agreement
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
   
}

// MARK: - Setup
private extension LoginViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
        self.view.backgroundColor = UIColor.white

        // 将视图添加到视图控制器的视图
        view.addSubview(loginBackgroundView)
        view.sendSubviewToBack(loginBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(markImageView)
        view.addSubview(accountInputView)
        view.addSubview(passwordInputView)
        view.addSubview(loginButton)
        view.addSubview(verificationCodeButton)
        view.addSubview(wechatLoginButton)
        view.addSubview(toggleButton)
        // 设置 textView 的 attributedText 在第一次访问时
        let attributedString = createAttributedString()
        privacyPolicyAndUserAgreementTextView.attributedText = attributedString
        
        // 添加textView到视图
        view.addSubview(privacyPolicyAndUserAgreementTextView)
        // 关闭按钮

    }
    // 创建并返回NSMutableAttributedString
    func createAttributedString() -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "阅读并同意《核蜂换电隐私政策》和《租赁协议》", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hex:0x666666FF)
        ])
        
        let privacyPolicyRange = (attributedString.string as NSString).range(of: "《核蜂换电隐私政策》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/index.html", range: privacyPolicyRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex:0x3171EFFF) , range: privacyPolicyRange)
        
        let rentalAgreementRange = (attributedString.string as NSString).range(of: "《租赁协议》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/member.html", range: rentalAgreementRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex:0x3171EFFF) , range: rentalAgreementRange)
        
        return attributedString
    }
    private func setupLayout() {
        // 约束代码，这里使用自动布局
       
        
        NSLayoutConstraint.activate([
//            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
//            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            //背景图布局
            loginBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            loginBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 90),

            markImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            markImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            markImageView.widthAnchor.constraint(equalToConstant: 120),
            markImageView.heightAnchor.constraint(equalToConstant: 35),

         
            // 手机号码输入框约束
            accountInputView.topAnchor.constraint(equalTo: markImageView.bottomAnchor, constant: 40),
            accountInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            accountInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            accountInputView.heightAnchor.constraint(equalToConstant: 50),
            // 密码输入框约束
            passwordInputView.topAnchor.constraint(equalTo: accountInputView.bottomAnchor, constant: 10),
            passwordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordInputView.heightAnchor.constraint(equalToConstant: 50),

            // 登录按钮约束
            loginButton.topAnchor.constraint(equalTo: passwordInputView.bottomAnchor, constant: 105),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // 验证码登录按钮约束
            verificationCodeButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            verificationCodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verificationCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verificationCodeButton.heightAnchor.constraint(equalToConstant: 40),
            
            // 隐私政策标签约束
            privacyPolicyAndUserAgreementTextView.heightAnchor.constraint(equalToConstant: 18),
            privacyPolicyAndUserAgreementTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyPolicyAndUserAgreementTextView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            privacyPolicyAndUserAgreementTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            toggleButton.trailingAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.leadingAnchor,constant: -4),
            toggleButton.centerYAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.centerYAnchor),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
            // 用户服务协议标签约束
            
        ])
        NSLayoutConstraint.activate([
            wechatLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wechatLoginButton.bottomAnchor.constraint(greaterThanOrEqualTo: privacyPolicyAndUserAgreementTextView.topAnchor, constant: -40),
            wechatLoginButton.bottomAnchor.constraint(lessThanOrEqualTo: privacyPolicyAndUserAgreementTextView.topAnchor, constant: -20),
            wechatLoginButton.widthAnchor.constraint(equalToConstant: 40),
            wechatLoginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - Public
extension LoginViewController {
    
}

// MARK: - Request
private extension LoginViewController {
    
}

// MARK: - Action
@objc private extension LoginViewController {
    // 点击微信登录按钮的事件处理
    func wechatLoginBehavior(){
        if WXApi.isWXAppInstalled(){
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"   // 请求用户信息的权限
            req.state = "核蜂动力"          // 自定义的状态标识符，用于识别请求
            
            WXApi.send(req) { success in
                if success {
                    print("微信请求发送成功")
                } else {
                    print("微信请求发送失败")
                }
            }
        }else{
            self.showInfo(withStatus: "没有安装微信")
        }
    }
    @objc func wechatLoginButtonTapped() {
        if LoginModel.shared.agreement == true {
            wechatLoginBehavior()
            
        }else{
            self.showPrivacyAlertController { alertAction in
                
            } sureBlock: { alertAction in
                self.toggleButton.isSelected = true
                LoginModel.shared.agreement = true
                self.wechatLoginBehavior()
            }

        }
        // 调用微信登录逻辑，比如使用微信SDK进行授权登录
        // 这里添加你的微信登录处理逻辑
        
    }
    private func loginBehavior(){
        let passwordMD5 = self.passwordInputView.passwordTextField.text?.md5 ?? ""

        postData(loginUrl, param: [
            "account": self.accountInputView.phoneNumberTextField.text ?? "",
            "password": passwordMD5,
            "type": "pw"
        ], isLoading: true, success: { (responseObject) in
            // Save account name to UserDefaults
            self.showSuccess(withStatus: "登录成功")
            AccountManager.shared.phoneNum = self.accountInputView.phoneNumberTextField.text
            
            // Save account using HFKeyedArchiverTool
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let account = HFAccount.mj_object(withKeyValues: body) {
                HFKeyedArchiverTool.saveAccount(account)
            }
            
            // Set the root view controller
            let nav = UINavigationController(rootViewController: MainTabBarController())
            UIViewController.ex_keyWindow()?.rootViewController = nav
        }, error: { (error) in
            // Handle error
            self.showError(withStatus: error.localizedDescription)

        })

        
    }
    @objc func toggle(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        LoginModel.shared.agreement = sender.isSelected

    }
    @objc func login(_ sender:UIButton){
        if LoginModel.shared.agreement == true {
            
            loginBehavior()
        }else{
            self.showPrivacyAlertController { alertAction in
                
            } sureBlock: { alertAction in
                LoginModel.shared.agreement = true
                self.toggleButton.isSelected = true
                self.loginBehavior()
            }

        }
        
    }
    @objc func close(_ sender:UIButton){
        self.dismiss(animated: true)
    }
    @objc func openPhoneLogin(_ sender:UIButton){
        
    }
    @objc func openPrivacyPolicy() {
        // 打开隐私政策的链接
        print("打开隐私政策")
    }
    
    @objc func openUserAgreement() {
        // 打开用户服务协议的链接
        print("打开用户服务协议")
    }
    @objc func goToPhoneLogin(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension LoginViewController {
    
}
extension UIImage {
    func resized(toSize newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
