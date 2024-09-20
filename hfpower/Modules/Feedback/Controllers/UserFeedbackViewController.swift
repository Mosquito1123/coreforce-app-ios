//
//  UserFeedbackViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/2.
//

import UIKit

class UserFeedbackViewController: BaseViewController,UITextFieldDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var nameTextView: CommonInputView = {
        let view = CommonInputView()
        view.placeholder = "请输入姓名"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var emailTextView: CommonInputView = {
        let view = CommonInputView()
        view.placeholder = "请输入邮箱"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var phoneNumTextView: CommonInputView = {
        let view = CommonInputView()
        view.placeholder = "请输入手机号"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var detailTextView:UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("提交反馈", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 1).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 1).toImage(), for: .selected)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 0.5).toImage(), for: .disabled)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(onSubmitted(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension UserFeedbackViewController {
    
    private func setupNavbar() {
        self.title = "用户反馈"
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
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
        appearance.backgroundImage = UIColor.white.toImage()
        appearance.shadowImage = UIColor.white.toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.nameTextView)
        self.view.addSubview(self.emailTextView)
        self.view.addSubview(self.phoneNumTextView)
        self.view.addSubview(self.detailTextView)
        self.view.addSubview(self.submitButton)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameTextView.heightAnchor.constraint(equalToConstant: 50),
            nameTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            nameTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            nameTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 14),
            nameTextView.bottomAnchor.constraint(equalTo: self.emailTextView.topAnchor,constant: -14),
            emailTextView.heightAnchor.constraint(equalToConstant: 50),
            emailTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            emailTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            emailTextView.bottomAnchor.constraint(equalTo: self.phoneNumTextView.topAnchor,constant: -14),
            phoneNumTextView.heightAnchor.constraint(equalToConstant: 50),
            phoneNumTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            phoneNumTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            phoneNumTextView.bottomAnchor.constraint(equalTo: self.detailTextView.topAnchor,constant: -14),
            detailTextView.heightAnchor.constraint(equalToConstant: 150),
            detailTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            detailTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            detailTextView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor,constant: -14),
            submitButton.heightAnchor.constraint(equalToConstant: 42),
            submitButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            submitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            
        ])
    }
}

// MARK: - Public
extension UserFeedbackViewController {
    
}

// MARK: - Request
private extension UserFeedbackViewController {
    
}

// MARK: - Action
@objc private extension UserFeedbackViewController {
    @objc func onSubmitted(_ sender:UIButton){
        if nameTextView.textField.text?.isEmpty ?? true {
            self.showError(withStatus: "姓名不能为空")
        } else if emailTextView.textField.text?.isEmpty ?? true {
            self.showError(withStatus: "邮箱不能为空")
        } else if phoneNumTextView.textField.text?.count ?? 0 < 11 {
            self.showError(withStatus: "手机号不能为空且不能小于11位")
        } else if detailTextView.text.isEmpty {
            self.showError(withStatus: "反馈内容不能为空")
        } else {
            self.postData(feedbackUrl,
                          param: ["name": nameTextView.textField.text ?? "",
                                  "email": emailTextView.textField.text ?? "",
                                  "phoneNum": phoneNumTextView.textField.text ?? "",
                                  "feedback": detailTextView.text ?? ""],
                          isLoading: true,
                          success: { responseObject in
                self.navigationController?.popViewController(animated: true)
            },
                          error: { error in
                // 处理错误
                self.showError(withStatus: error.localizedDescription)
            })
        }
        
    }
}

// MARK: - Private
private extension UserFeedbackViewController {
    
}
