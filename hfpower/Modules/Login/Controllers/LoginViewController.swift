//
//  LoginViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit
import SVProgressHUD
class LoginViewController:UIViewController, UITextViewDelegate {
    let networkingClient = NetworkingClient(apiKey: "")
    // MARK: - Accessor
    
    // MARK: - Subviews
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
        let button = UIButton(type: .system)
        // 登录按钮
        button.setTitle("立即登录", for: .normal)
        button.setTitle("立即登录", for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        let imageEnabled = UIColor(named: "447AFE")?.toImage()
        let imageDisabled =  UIColor(named: "447AFE 20")?.toImage()
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
        button.setTitleColor(UIColor(named: "797979"), for: .normal)
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

        self.view.backgroundColor = UIColor.white
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
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//
//        
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleButton.isSelected = LoginModel.shared.agreement
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
   
}

// MARK: - Setup
private extension LoginViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
        
        // 将视图添加到视图控制器的视图
        view.addSubview(loginBackgroundView)
        view.sendSubviewToBack(loginBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(markImageView)
        view.addSubview(accountInputView)
        view.addSubview(passwordInputView)
        view.addSubview(loginButton)
        view.addSubview(verificationCodeButton)
        view.addSubview(toggleButton)
        // 设置 textView 的 attributedText 在第一次访问时
        let attributedString = createAttributedString()
        privacyPolicyAndUserAgreementTextView.attributedText = attributedString
        
        // 添加textView到视图
        view.addSubview(privacyPolicyAndUserAgreementTextView)
        // 关闭按钮
        view.addSubview(closeButton)

    }
    // 创建并返回NSMutableAttributedString
    func createAttributedString() -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "阅读并同意《核蜂换电隐私政策》和《租赁协议》", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(named: "666666") ?? UIColor.black
        ])
        
        let privacyPolicyRange = (attributedString.string as NSString).range(of: "《核蜂换电隐私政策》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/index.html", range: privacyPolicyRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: privacyPolicyRange)
        
        let rentalAgreementRange = (attributedString.string as NSString).range(of: "《租赁协议》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/member.html", range: rentalAgreementRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: rentalAgreementRange)
        
        return attributedString
    }
    private func setupLayout() {
        // 约束代码，这里使用自动布局
       
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            //背景图布局
            loginBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            loginBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 116),
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
            privacyPolicyAndUserAgreementTextView.heightAnchor.constraint(equalToConstant: 40),
            privacyPolicyAndUserAgreementTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyPolicyAndUserAgreementTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65),
            privacyPolicyAndUserAgreementTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            toggleButton.trailingAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.leadingAnchor,constant: -8),
            toggleButton.topAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.topAnchor , constant: 3),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
            // 用户服务协议标签约束
            
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
    private func loginBehavior(){
        NetworkService<AuthAPI>().request(.login(username: accountInputView.phoneNumberTextField.text ?? "", password: passwordInputView.passwordTextField.text ?? "", type: "pw"), model:TokenResponse.self) { result in
            switch result{
            case .success(let response):
                TokenManager.shared.accessToken = response?.accessToken
                TokenManager.shared.accessTokenExpiration = response?.accessTokenExpiration
                TokenManager.shared.refreshToken = response?.refreshToken
                TokenManager.shared.refreshTokenExpiration = response?.refreshTokenExpiration
                AccountManager.shared.phoneNum = self.accountInputView.phoneNumberTextField.text
                self.navigationController?.dismiss(animated: true)

            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)

            }
        }
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
        let vc = LoginPhoneViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
