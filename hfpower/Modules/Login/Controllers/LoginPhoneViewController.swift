//
//  LoginPhoneViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginPhoneViewController: UIViewController,UITextViewDelegate {
    
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
    lazy var vCodeInputView:LoginVCodeInputView = {
        let view = LoginVCodeInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var inviteCodeInputView:LoginInviteCodeInputView = {
        let view = LoginInviteCodeInputView()
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
        let imageEnabled = image(from: UIColor(named: "447AFE") ?? .blue)
        let imageDisabled = image(from: UIColor(named: "447AFE 20") ?? .blue)
        button.setBackgroundImage(imageEnabled, for: .normal)
        button.setBackgroundImage(imageDisabled, for: .disabled)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    lazy var verificationCodeButton :UIButton = {
        let button = UIButton(type: .custom)

        // 验证码登录按钮
        button.setTitle("切换密码登录", for: .normal)
        button.setTitleColor(UIColor(named: "797979"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(goBackToCommonLogin(_:)), for: .touchUpInside)
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
        self.loginButton.isEnabled = !(self.accountInputView.phoneNumberTextField.text?.isEmpty ?? true) && !(self.vCodeInputView.vCodeTextField.text?.isEmpty ?? true)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
}

// MARK: - Setup
private extension LoginPhoneViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        // 将视图添加到视图控制器的视图
        view.addSubview(loginBackgroundView)
        view.sendSubviewToBack(loginBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(markImageView)
        view.addSubview(accountInputView)
        view.addSubview(vCodeInputView)
        view.addSubview(inviteCodeInputView)
        view.addSubview(loginButton)
        view.addSubview(verificationCodeButton)
        view.addSubview(toggleButton)
        // 设置 textView 的 attributedText 在第一次访问时
        let attributedString = createAttributedString()
        privacyPolicyAndUserAgreementTextView.attributedText = attributedString
        
        // 添加textView到视图
        view.addSubview(privacyPolicyAndUserAgreementTextView)
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
            // 验证码输入框约束
            vCodeInputView.topAnchor.constraint(equalTo: accountInputView.bottomAnchor, constant: 10),
            vCodeInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vCodeInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vCodeInputView.heightAnchor.constraint(equalToConstant: 50),
            inviteCodeInputView.topAnchor.constraint(equalTo: vCodeInputView.bottomAnchor, constant: 10),
            inviteCodeInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inviteCodeInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inviteCodeInputView.heightAnchor.constraint(equalToConstant: 50),

            // 登录按钮约束
            loginButton.topAnchor.constraint(equalTo: inviteCodeInputView.bottomAnchor, constant: 45.5),
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

            toggleButton.trailingAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.leadingAnchor ,constant: -8),
            toggleButton.topAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.topAnchor , constant: 3),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
            // 用户服务协议标签约束
            
        ])
    }
}

// MARK: - Public
extension LoginPhoneViewController {
    
}

// MARK: - Request
private extension LoginPhoneViewController {
    
}

// MARK: - Action
@objc private extension LoginPhoneViewController {
    @objc func toggle(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
    }
    @objc func goBackToCommonLogin(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
      
    }
}

// MARK: - Private
private extension LoginPhoneViewController {
    func image(from color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        // 创建一个图形上下文
        let renderer = UIGraphicsImageRenderer(size: size)
        
        // 使用图形上下文渲染图像
        let image = renderer.image { context in
            // 设置绘图颜色
            context.cgContext.setFillColor(color.cgColor)
            
            // 绘制一个矩形填充整个图形上下文
            context.cgContext.fill(CGRect(origin: .zero, size: size))
        }
        
        return image
    }
}
