//
//  ChangePhoneNumberViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class ChangePhoneNumberViewController: UIViewController {
    
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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
private extension ChangePhoneNumberViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = true
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.headerBackgroundView)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
    }
    
    private func setupLayout() {
        
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
}

// MARK: - Private
private extension ChangePhoneNumberViewController {
    
}
