//
//  InviteCodeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/28.
//

import UIKit

class InviteCodeViewController: BaseViewController {
    
    // MARK: - Accessor
    var inviteString: String? {
        didSet {
            titleLabel.text = inviteString
        }
    }

    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var inviteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("点击复制", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.tintAdjustmentMode = .automatic
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .highlighted)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(inviteButtonClicked(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupLayout()
        loadInviteCode()
        setupNavbar()
    }
    
    func loadInviteCode(){
        NetworkService<MemberAPI,InviteCodeResponse>().request(.memberInviteCode) { result in
            switch result {
            case .success(let response):
                self.inviteString = response?.inviteCode
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)

                
            }
        }
    }
    
}

// MARK: - Setup
private extension InviteCodeViewController {
    
    private func setupNavbar() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.title = "我的邀请码"

        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize.init(width: 12, height: 20)), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        // 设置背景色为白色
        appearance.backgroundImage = UIColor.white.toImage()
        appearance.shadowImage = UIColor.white.toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(rgba: 0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        self.view.addSubview(titleLabel)
        self.view.addSubview(inviteButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inviteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inviteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
        ])
    }
}

// MARK: - Public
extension InviteCodeViewController {
    
}

// MARK: - Request
private extension InviteCodeViewController {
    
}

// MARK: - Action
@objc private extension InviteCodeViewController {
    @objc func inviteButtonClicked(_ sender:UIButton){
        UIPasteboard.general.string = inviteString
            if UIPasteboard.general.string == nil {
                self.showError(withStatus: "复制失败")
            } else {
                self.showSuccess(withStatus: "已复制")
            }
    }
}

// MARK: - Private
private extension InviteCodeViewController {
    
}
