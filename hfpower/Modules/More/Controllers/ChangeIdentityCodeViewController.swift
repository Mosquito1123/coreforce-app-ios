//
//  ChangeIdentityCodeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/13.
//

import UIKit

class ChangeIdentityCodeViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "修改密码"
        label.font = UIFont.systemFont(ofSize: 26,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "密码必须6-16位数字和字母组合，如未设置过密码可不输入旧密码"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex:0x4D4D4DFF)
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
    
}

// MARK: - Setup
private extension ChangeIdentityCodeViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension ChangeIdentityCodeViewController {
    
}

// MARK: - Request
private extension ChangeIdentityCodeViewController {
    
}

// MARK: - Action
@objc private extension ChangeIdentityCodeViewController {
    
}

// MARK: - Private
private extension ChangeIdentityCodeViewController {
    
}
