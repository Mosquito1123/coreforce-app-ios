//
//  PersonalInfoTableHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class PersonalInfoTableHeaderView: UIView {

    // MARK: - Accessor
    var editAction:ButtonActionBlock?
    // MARK: - Subviews
    // 创建圆形头像
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2.5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // 创建编辑图标按钮
    lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "edit"), for: .normal) //
        button.setImage(UIImage(named: "edit"), for: .selected) //
        button.setBackgroundImage(UIColor.white.circularImage(diameter: 33), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalInfoTableHeaderView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        self.addSubview(self.avatarImageView)
        self.addSubview(self.editButton)
    }
    
    private func setupLayout() {
        // 布局头像视图
                NSLayoutConstraint.activate([
                    avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    avatarImageView.widthAnchor.constraint(equalToConstant: 100),
                    avatarImageView.heightAnchor.constraint(equalToConstant: 100)
                ])
                
                // 布局编辑按钮
                NSLayoutConstraint.activate([
                    editButton.widthAnchor.constraint(equalToConstant: 33),
                    editButton.heightAnchor.constraint(equalToConstant: 33),
                    editButton.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
                    editButton.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor)
                ])
    }
    
}

// MARK: - Public
extension PersonalInfoTableHeaderView {
    
}

// MARK: - Action
@objc private extension PersonalInfoTableHeaderView {
    @objc func editButtonTapped(_ sender:UIButton) {
        self.editAction?(sender)
    }
}

// MARK: - Private
private extension PersonalInfoTableHeaderView {
    
}
