//
//  CabinetLocationView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetLocationView: UIView {

    // MARK: - Accessor
    var location:String?{
        didSet{
            textLabel.text = "\(CityCodeManager.shared.cityName ?? "")\(location ?? "")"
        }
    }
    var relocate:ButtonActionBlock?
    // MARK: - Subviews
    // 使用懒加载创建图标
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "search_list_icon_location")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 使用懒加载创建文字标签
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "青岛市二〇二四年〇五月三十一日"
        label.numberOfLines = 1
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 使用懒加载创建按钮
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("重新定位", for: .normal)
        button.setImage(UIImage(named: "device_refresh"), for: .normal)
        button.setTitleColor(UIColor(rgba:0x447AFEFF), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.setImagePosition(type: .imageLeft, Space: 3)
    }
}

// MARK: - Setup
private extension CabinetLocationView {
    
    private func setupSubviews() {
        // 添加子视图
        addSubview(iconImageView)
        addSubview(textLabel)
        addSubview(actionButton)
    }
    
    private func setupLayout() {
        // 设置自动布局约束
        NSLayoutConstraint.activate([
            // 图标约束
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // 文字标签约束
            textLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 2),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 按钮约束
            actionButton.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 确保标签和按钮之间的距离
            
        ])
    }
    
}

// MARK: - Public
extension CabinetLocationView {
    
}

// MARK: - Action
@objc private extension CabinetLocationView {
    @objc func actionButtonTapped(_ sender:UIButton){
        self.relocate?(sender)
    }
}

// MARK: - Private
private extension CabinetLocationView {
    
}
