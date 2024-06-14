//
//  RealNameAuthViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit
import AliyunFaceAuthFacade
class RealNameAuthViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    private(set) lazy var startCertification: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("下一步，人脸认证", for: .disabled)
        button.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .disabled)
        button.setBackgroundImage(UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).toImage(), for: .disabled)
        button.setTitle("下一步，人脸认证", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIColor(red: 57/255, green: 77/255, blue: 191/255, alpha: 1).toImage(), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(startCerticationClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "完成认证即可换电"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "实名认证需要验证您本人信息，一旦确认后将不可更改。为了保障账户安全，需要您授权或填写相关身份信息用于账户实名认证"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var IDCardIdentifyView: HFIDCardIdentifyView = {
        let view = HFIDCardIdentifyView()
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
    
    private var certifyId: String?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 低优先级后台任务
        // 后台任务，例如数据处理、网络请求
        AliyunFaceAuthFacade.initSDK()
        self.view.backgroundColor = .white
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension RealNameAuthViewController {
    
    private func setupNavbar() {
        self.title = "实名认证"
        let item = UIBarButtonItem(barButtonSystemItem: .close, target: self, action:  #selector(closeButton(_:)))
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = item
    }
    
    // MARK: - Setup
    private func setupSubviews() {
        view.addSubview(summaryLabel)
        view.addSubview(tipsLabel)
        view.addSubview(IDCardIdentifyView)
        view.addSubview(nameView)
        view.addSubview(IDNumberView)
        view.addSubview(startCertification)
    }
    
    private func setupLayout() {
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
            
            nameView.topAnchor.constraint(equalTo: IDCardIdentifyView.bottomAnchor, constant: 14),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            nameView.heightAnchor.constraint(equalToConstant: 50),
            
            IDNumberView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 14),
            IDNumberView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            IDNumberView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            IDNumberView.heightAnchor.constraint(equalToConstant: 50),
            
            startCertification.topAnchor.constraint(equalTo: IDNumberView.bottomAnchor, constant: 14),
            startCertification.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            startCertification.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            startCertification.heightAnchor.constraint(equalToConstant: 50)
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
    @objc private func startCerticationClick(_ sender:UIButton) {
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
        NetworkService<MemberAPI,MemberRpResponse>().request(.memberRpInit(params: p)) { result in
            switch result {
            case.success(let response):
                var extParams: [String: Any] = [
                    ZIM_EXT_PARAMS_KEY_OCR_BOTTOM_BUTTON_COLOR: "394DBF",
                    ZIM_EXT_PARAMS_KEY_OCR_FACE_CIRCLE_COLOR: "394DBF",
                    "returnVideo": "true",
                    ZIM_EXT_PARAMS_KEY_USE_VIDEO_UPLOAD: "true",
                    "cancelImage": UIImage(named: "setup-head-default") ?? UIImage(),
                    "imageOrientation": "right"
                ]
                extParams["currentCtr"] = self
                AliyunFaceAuthFacade.verify(with: response?.certifyId ?? "", extParams: extParams) { zimResponse in
                    switch zimResponse.code {
                        
                    case .ZIMResponseSuccess:
                        NetworkService<MemberAPI,MemberRpResponse>().request(.memberRpDescribe(certifyId: response?.certifyId ?? "")) { result in
                            switch result{
                            case .success:
                                AccountManager.shared.isAuth = 1
                                self.navigationController?.dismiss(animated: true)
                            case .failure(let error):
                                self.showError(withStatus: error.localizedDescription)
                            }
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
            case .failure(let error):
                
                self.showError(withStatus: error.localizedDescription)
            }
        }
    }
    @objc func closeButton(_ sender:UIBarButtonItem){
        self.navigationController?.dismiss(animated: true)
    }
}

// MARK: - Private
private extension RealNameAuthViewController {
    
}
