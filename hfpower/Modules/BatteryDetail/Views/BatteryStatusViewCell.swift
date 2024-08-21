//
//  BatteryStatusViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryStatusViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "80%"
        label.font = UIFont(name: "DIN Alternate Bold", size: 30)
        label.textColor = UIColor(rgba:0x262626FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "剩余电量"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "device_battery_high")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("使用中", for: .normal)
        button.setTitle("使用中", for: .highlighted)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .highlighted)
        button.setImage(UIColor(rgba: 0x447AFEFF).circularImage(diameter: 6), for: .normal)
        button.setImage(UIColor(rgba: 0x447AFEFF).circularImage(diameter: 6), for: .highlighted)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).toImage(), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(rgba:0x333333FF), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setImage(UIImage(named: "device_navigate"), for: .normal)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgba:0xE5E6EBFF).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var locationButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("李沧区青山路700号", for: .normal)
        button.setTitleColor(UIColor(rgba:0x262626FF), for: .normal)
        button.setTitleColor(UIColor(rgba:0x262626FF), for: .highlighted)
        button.setImage(UIImage(named: "device_refresh"), for: .normal)
        button.setImage(UIImage(named: "device_refresh"), for: .highlighted)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatteryStatusViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatteryStatusViewCell { return cell }
        return BatteryStatusViewCell()
    }
    
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
private extension BatteryStatusViewCell {
    
    private func setupSubviews() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        self.backgroundView = backgroundView

        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.statusButton)
        self.contentView.addSubview(self.locationButton)
        self.contentView.addSubview(self.navigateButton)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)

        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            statusButton.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 12),
            statusButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),
            statusButton.widthAnchor.constraint(equalToConstant: 90),
            statusButton.heightAnchor.constraint(equalToConstant: 30),
            locationButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 20),
            locationButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor,constant: -30),
            navigateButton.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor,constant: 10),
            navigateButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            navigateButton.widthAnchor.constraint(equalToConstant: 62),
            navigateButton.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: 14),
            titleLabel.centerXAnchor.constraint(equalTo: statusButton.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

        ])
    }
    
}

// MARK: - Public
extension BatteryStatusViewCell {
    
}

// MARK: - Action
@objc private extension BatteryStatusViewCell {
    
}

// MARK: - Private
private extension BatteryStatusViewCell {
    
}