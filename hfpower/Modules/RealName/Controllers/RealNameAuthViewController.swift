//
//  RealNameAuthViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit
import AliyunFaceAuthFacade
class RealNameAuthViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var loginBackgroundView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // 其他配置...
        return imageView
    }()
    private(set) lazy var startCertification: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("验证信息", for: .disabled)
        button.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .disabled)
        button.setBackgroundImage(UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).toImage(), for: .disabled)
        button.setTitle("验证信息", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIColor(hex: 0x447AFEFF).toImage(), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(startCerticationClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "实名认证"
        label.textColor = UIColor(hex: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "根据《反恐怖法》、《移动互联网应用程序信息服务管理规定》等法律法规要求，请提供真实的身份信息，认证后无需再次采集"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex: 0x4D4D4DFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var IDCardIdentifyView: HFIDCardIdentifyView = {
        let view = HFIDCardIdentifyView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.buttonActionBlock = { [weak self] sender in
            guard let weakSelf = self else { return }
            let AVCaptureVC = JYBDIDCardVC()
            AVCaptureVC.modalPresentationStyle = .fullScreen
            AVCaptureVC.finish = { info, image in
                weakSelf.nameView.nameTextField.text = info?.name
                weakSelf.IDNumberView.numberTextField.text = info?.num
                if weakSelf.nameView.nameTextField.text?.isEmpty == false && weakSelf.IDNumberView.numberTextField.text?.isEmpty == false {
                    weakSelf.startCertification.isEnabled = true
                } else {
                    weakSelf.startCertification.isEnabled = false
                }
            }
            weakSelf.present(AVCaptureVC, animated: true, completion: nil)
        }
        return view
    }()
    
    private(set) lazy var nameView: HFAuthNameView = {
        let view = HFAuthNameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameBlock = { [weak self] textField in
            guard let weakSelf = self else { return }
            if weakSelf.nameView.nameTextField.text?.isEmpty == false && weakSelf.IDNumberView.numberTextField.text?.isEmpty == false {
                weakSelf.startCertification.isEnabled = true
            } else {
                weakSelf.startCertification.isEnabled = false
            }
        }
        return view
    }()
    
    private(set) lazy var IDNumberView: HFAuthIDNumberView = {
        let view = HFAuthIDNumberView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberBlock = { [weak self] textField in
            guard let weakSelf = self else { return }
            if weakSelf.nameView.nameTextField.text?.isEmpty == false && weakSelf.IDNumberView.numberTextField.text?.isEmpty == false {
                weakSelf.startCertification.isEnabled = true
            } else {
                weakSelf.startCertification.isEnabled = false
            }
        }
        return view
    }()
    lazy var toggleButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "unselected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        button.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
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
    private var certifyId: String?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 低优先级后台任务
        // 后台任务，例如数据处理、网络请求
        AliyunFaceAuthFacade.initSDK()
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleButton.isSelected = LoginModel.shared.agreement
        
    }
}

// MARK: - Setup
private extension RealNameAuthViewController {
    
    private func setupNavbar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        // 设置背景色为白色
        appearance.configureWithTransparentBackground()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Setup
    private func setupSubviews() {
        self.view.backgroundColor = .white
        view.addSubview(loginBackgroundView)
        view.addSubview(summaryLabel)
        view.addSubview(tipsLabel)
        view.addSubview(IDCardIdentifyView)
        view.addSubview(nameView)
        view.addSubview(IDNumberView)
        view.addSubview(startCertification)
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
        NSLayoutConstraint.activate([
            loginBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            loginBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            
            tipsLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 14),
            tipsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            tipsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            
            IDCardIdentifyView.topAnchor.constraint(equalTo: tipsLabel.bottomAnchor, constant: 50),
            IDCardIdentifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            IDCardIdentifyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            IDCardIdentifyView.heightAnchor.constraint(equalToConstant: 50),
            
            nameView.topAnchor.constraint(equalTo: tipsLabel.bottomAnchor, constant: 34),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            nameView.heightAnchor.constraint(equalToConstant: 50),
            
            IDNumberView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 14),
            IDNumberView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            IDNumberView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            IDNumberView.heightAnchor.constraint(equalToConstant: 50),
            
            startCertification.topAnchor.constraint(equalTo: IDNumberView.bottomAnchor, constant: 139),
            startCertification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            startCertification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            startCertification.heightAnchor.constraint(equalToConstant: 50),
            // 隐私政策标签约束
            privacyPolicyAndUserAgreementTextView.heightAnchor.constraint(equalToConstant: 18),
            privacyPolicyAndUserAgreementTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 51),
            privacyPolicyAndUserAgreementTextView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.75),
            privacyPolicyAndUserAgreementTextView.bottomAnchor.constraint(equalTo: startCertification.topAnchor,constant: -17),
            
            toggleButton.trailingAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.leadingAnchor,constant: -4),
            toggleButton.centerYAnchor.constraint(equalTo: privacyPolicyAndUserAgreementTextView.centerYAnchor),
            toggleButton.heightAnchor.constraint(equalToConstant: 25),
            toggleButton.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
}

// MARK: - Public
extension RealNameAuthViewController {
    
}

// MARK: - Request
private extension RealNameAuthViewController {
    
}

// MARK: - Action
@objc private extension RealNameAuthViewController {
    @objc func toggle(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        LoginModel.shared.agreement = sender.isSelected
        
    }
    // MARK: - Helper Methods
    private func convertToJsonData(_ dict: [AnyHashable: Any]?) -> String? {
        guard let dict = dict else { return nil }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            var jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            jsonString = jsonString.replacingOccurrences(of: " ", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            return jsonString
        } catch {
            return nil
        }
    }
    func startCertificationBehavior() {
        let identificationNumberPattern = "\\d{17}[[0-9],0-9xX]"
        let identificationNumberPredicate = NSPredicate(format: "SELF MATCHES %@", identificationNumberPattern)
        guard identificationNumberPredicate.evaluate(with: IDNumberView.numberTextField.text) else {
            self.showInfo(withStatus: "身份证格式不正确,请检查后重试!")
            return
        }
        
        var info = AliyunFaceAuthFacade.getMetaInfo()
        info["appName"] = "tie.battery.qi"
        guard let paramString = convertToJsonData(info) else { return }
        var p: [String: Any] = ["metaInfo": paramString]
        if let name = nameView.nameTextField.text, !name.isEmpty, let number = IDNumberView.numberTextField.text, !number.isEmpty {
            p["certName"] = name
            p["certNo"] = number
        }
        self.postData(memberRpInitUrl, param: p, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let certifyId = body["certifyId"] as? String{
                var extParams: [String: Any] = [
                    ZIM_EXT_PARAMS_KEY_OCR_BOTTOM_BUTTON_COLOR: "394DBF",
                    ZIM_EXT_PARAMS_KEY_OCR_FACE_CIRCLE_COLOR: "394DBF",
                    "returnVideo": "true",
                    ZIM_EXT_PARAMS_KEY_USE_VIDEO_UPLOAD: "true",
                    "cancelImage": UIImage(named: "setup-head-default") ?? UIImage(),
                    "imageOrientation": "right"
                ]
                extParams["currentCtr"] = self
                AliyunFaceAuthFacade.verify(with: certifyId, extParams: extParams) { zimResponse in
                    switch zimResponse.code {
                        
                    case .ZIMResponseSuccess:
                        self.postData(memberRpDescribeUrl, param: ["certifyId":certifyId], isLoading: true) { responseObject in
                            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let code = body["code"] as? String,code == "200"{
                                UIViewController.ex_keyWindow()?.showWindowSuccess(withStatus: "实名认证已通过")
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        } error: { error in
                            self.showError(withStatus: error.localizedDescription)
                            
                        }
                        
                        
                        
                    case .ZIMInternalError:
                        self.showError(withStatus: "初始化失败")
                    case .ZIMInterrupt:
                        self.showError(withStatus: "用户退出")
                    case .ZIMNetworkfail:
                        self.showError(withStatus: "网络错误")
                    case .ZIMTIMEError:
                        self.showError(withStatus: "设备时间设置不对")
                    case .ZIMResponseFail:
                        self.showError(withStatus: "刷脸失败")
                    @unknown default:
                        self.showError(withStatus: "初始化失败")
                        
                    }
                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            
        }
        
    }
    @objc private func startCerticationClick(_ sender:UIButton) {
        if LoginModel.shared.agreement == true {
            
            startCertificationBehavior()
        }else{
            self.showPrivacyAlertController { alertAction in
                
            } sureBlock: { alertAction in
                LoginModel.shared.agreement = true
                self.toggleButton.isSelected = true
                self.startCertificationBehavior()
            }
            
        }
        
    }
    
}

// MARK: - Private
private extension RealNameAuthViewController {
    
}
