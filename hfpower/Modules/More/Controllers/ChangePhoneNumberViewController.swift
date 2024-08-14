//
//  ChangePhoneNumberViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class ChangePhoneNumberViewController: UIViewController,UITextViewDelegate {
    
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
    lazy var vCodeInputView:LoginVCodeInputView = {
        let view = LoginVCodeInputView()
        view.backgroundColor = UIColor(rgba: 0xF5F7FBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // 懒加载创建UITextView
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.delegate = self
        tv.backgroundColor = .clear
        
        // 原始字符串
        let text = "无法接收短信，选择 密码验证 或 身份验证"
        
        // 创建一个可变的富文本字符串
        let attributedString = NSMutableAttributedString(string: text)
        
        // 设置普通文本的属性
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(rgba: 0x4D4D4DFF),
            .font: UIFont.systemFont(ofSize: 14)
        ]
        attributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: text.count))
        
        // 设置链接文本的属性
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(rgba: 0x447AFEFF),
            .font: UIFont.systemFont(ofSize: 14),
            .link: "hfpower://"
        ]
        
        // 设置“密码验证”和“身份验证”部分为链接
        let passwordRange = (text as NSString).range(of: "密码验证")
        let identityRange = (text as NSString).range(of: "身份验证")
        
        attributedString.addAttributes(linkAttributes, range: passwordRange)
        attributedString.addAttributes(linkAttributes, range: identityRange)
        
        // 赋值给UITextView的富文本属性
        tv.attributedText = attributedString
        
        // 设置可点击部分的链接属性
        tv.linkTextAttributes = [
            .foregroundColor: UIColor(rgba: 0x447AFEFF),
            .font: UIFont.systemFont(ofSize: 14),
        ]
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
    
    // UITextView点击链接时的回调
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let text = (textView.text ?? "") as NSString
        let passwordRange = text.range(of: "密码验证")
        let identityRange = text.range(of: "身份验证")
        
        if NSLocationInRange(characterRange.location, passwordRange) {
            print("点击了密码验证")
            // 跳转到密码验证页面
            let vPassword = ChangePhoneNumberVPasswordViewController()
            self.navigationController?.pushViewController(vPassword, animated: true)
            return false
        } else if NSLocationInRange(characterRange.location, identityRange) {
            print("点击了身份验证")
            // 跳转到身份验证页面
            let vIdentityCode = ChangePhoneNumberVIdentityCodeViewController()
            self.navigationController?.pushViewController(vIdentityCode, animated: true)
            return false
        }
        return true
    }
}

// MARK: - Setup
private extension ChangePhoneNumberViewController {
    
    private func setupNavbar() {
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.vCodeInputView)
        self.view.addSubview(self.textView)
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
            vCodeInputView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -24),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 22),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            textView.heightAnchor.constraint(equalToConstant: 30),
            textView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -198),
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
        
    }
}

// MARK: - Private
private extension ChangePhoneNumberViewController {
    
}
