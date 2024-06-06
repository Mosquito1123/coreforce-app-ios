//
//  LoginVCodeInputView.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit
import SVProgressHUD

class LoginVCodeInputView: UIView {

    // MARK: - Accessor
    var phoneNum:String?
    var sendCodeAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var logoView :UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "v_code_input")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var vCodeTextField :UITextField = {
        let textField = UITextField()
        // 手机号码输入框
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = .asciiCapableNumberPad
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"333333") ?? UIColor.black]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入验证码", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"A0A0A0") ?? UIColor.black])
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var sendButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("获取验证码", for:.normal)
        button.setTitleColor(UIColor(named: "447AFE"), for: .normal)
        button.setTitleColor(UIColor(named: "447AFE 80"), for: .disabled)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(sendVCode(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var timer: Timer?
    var seconds = 60
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "F5F7FB")
        self.layer.cornerRadius = 25
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension LoginVCodeInputView {
    
    private func setupSubviews() {
        addSubview(logoView)
        addSubview(vCodeTextField)
        addSubview(sendButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: vCodeTextField.leadingAnchor, constant: -14),
            logoView.widthAnchor.constraint(equalToConstant: 18),
            logoView.heightAnchor.constraint(equalToConstant: 18),
            vCodeTextField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            vCodeTextField.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor,constant: -14),
            sendButton.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),

            
        ])
    }
    
}

// MARK: - Public
extension LoginVCodeInputView :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(named: "3171EF")?.cgColor
        self.layer.borderWidth = 1.5
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0

    }
}

// MARK: - Action
@objc private extension LoginVCodeInputView {
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let pattern = "^[1]([3-9])[0-9]{9}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: phoneNumber.utf16.count)
        if let match = regex?.firstMatch(in: phoneNumber, options: [], range: range) {
            return match.range.location != NSNotFound
        }
        return false
    }
    @objc func sendVCode(_ sender:UIButton){
        if self.isValidPhoneNumber(phoneNum ?? ""){
            NetworkService<AuthAPI>().request(.sendSMSCode(phoneNumber: phoneNum ?? ""), model: BlankResponse.self) { result in
                switch result{
                case .success(_):
                    self.sendCodeAction?(sender)
                    self.startTimer()
                    sender.isEnabled = false
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }else{
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setMinimumDismissTimeInterval(1.5)
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            
        }
        
       // Disable the button when tapped
    }
    
    func startTimer() {
        sendButton.setTitle("\(seconds) 秒", for: .disabled)


        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds > 0 {
            seconds -= 1
            sendButton.setTitle("\(seconds) 秒", for: .disabled)

        } else {
            timer?.invalidate()
            timer = nil
            seconds = 60
            sendButton.isEnabled = true // Enable the button after 60 seconds
            sendButton.setTitle("重新发送", for: .normal)
            sendButton.setTitleColor(UIColor(named: "447AFE"), for: .normal)

        }
    }
}

// MARK: - Private
private extension LoginVCodeInputView {
    
}
