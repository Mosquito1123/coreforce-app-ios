//
//  PersonalPackageCardViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalPackageCardViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var sureAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var mainView: UIImageView = {
        let mainView = UIImageView()
        mainView.image = UIImage(named: "package_card_button_bg")
        mainView.isUserInteractionEnabled = true
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "package_l")
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.text = "购买套餐卡全年最高可省1800元"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 72, height: 31)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(hex:0x333333FF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x333333FF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor(hex:0xFFCF57FF), for: .normal)
        button.setTitleColor(UIColor(hex:0xFFCF57FF), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitle("立即购买", for: .normal)
        button.setTitle("立即购买", for: .highlighted)
        button.layer.cornerRadius = 15.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> PersonalPackageCardViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalPackageCardViewCell { return cell }
        return PersonalPackageCardViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 

        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalPackageCardViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.addSubview(self.mainView)
        self.mainView.addSubview(iconView)
        self.mainView.addSubview(titleLabel)
        self.mainView.addSubview(sureButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            self.mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8),
            self.mainView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -8),
            self.mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),

        ])
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor,constant: 12),
            iconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconView.centerYAnchor.constraint(equalTo: sureButton.centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor,constant: -4),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: sureButton.leadingAnchor,constant: -14),
            sureButton.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor,constant: -12),
            sureButton.heightAnchor.constraint(equalToConstant: 31),
            sureButton.widthAnchor.constraint(equalToConstant: 72),
            sureButton.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 12),
            sureButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -12),

        ])
    }
    
}

// MARK: - Public
extension PersonalPackageCardViewCell {
    
}

// MARK: - Action
@objc private extension PersonalPackageCardViewCell {
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
}

// MARK: - Private
private extension PersonalPackageCardViewCell {
    
}
