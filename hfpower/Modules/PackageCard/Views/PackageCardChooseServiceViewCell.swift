//
//  PackageCardChooseServiceViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit
enum PackageCardServiceType:Int{
    case battery
    case bike
}
class PackageCardChooseServiceViewCell: BaseTableViewCell<PackageCardChooseService> {
    class TableHeaderView: UIView {
        
        // 懒加载标签
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "选择服务"
            label.textColor = UIColor(rgba: 0x666666FF)
            label.font = UIFont.systemFont(ofSize: 13)
            label.textAlignment = .left
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        private func setupViews() {
            self.backgroundColor = .white
            addSubview(titleLabel)
            
            // 设置约束
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.5),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            ])
        }
    }
    // MARK: - Accessor
    var sureAction:ButtonActionBlock?
    override func configure() {
        self.titleLabel.text = element?.title
        self.contentLabel.text = element?.content
        if let type = PackageCardServiceType(rawValue: element?.type ?? 0){
            switch type {
            case .battery:
                self.containerView.backgroundColor = UIColor(rgba: 0xEBFBF1FF)
                self.titleLabel.textColor = UIColor(rgba:0x12B858FF)
                self.contentLabel.textColor = UIColor(rgba:0x12B858FF)
                self.iconImageView.image = UIImage(named: "battery_type")
                self.sureButton.setBackgroundImage(UIColor(rgba:0x39D97CFF).toImage(), for: .normal)
                self.sureButton.setBackgroundImage(UIColor(rgba:0x39D97CFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
            case .bike:
                self.containerView.backgroundColor = UIColor(rgba: 0xECF1FEFF)
                self.titleLabel.textColor = UIColor(rgba:0x447AFEFF)
                self.contentLabel.textColor = UIColor(rgba:0x447AFEFF)
                self.iconImageView.image = UIImage(named: "motorcycle")
                self.sureButton.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .normal)
                self.sureButton.setBackgroundImage(UIColor(rgba:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)


        
            }
        }
    }
    
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "换电套餐"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(rgba:0x12B858FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgba:0x447AFEFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 74, height: 40)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("购买", for: .normal)
        button.setTitle("购买", for: .highlighted)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PackageCardChooseServiceViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PackageCardChooseServiceViewCell { return cell }
        return PackageCardChooseServiceViewCell(style: .default, reuseIdentifier: identifier)
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
private extension PackageCardChooseServiceViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(iconImageView)
        self.containerView.addSubview(contentLabel)
        self.containerView.addSubview(sureButton)


    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 23.5),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentLabel.topAnchor, constant: -10),
            contentLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 16),
            contentLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -21.5),
            sureButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -14),
            sureButton.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            sureButton.widthAnchor.constraint(equalToConstant: 74),
            sureButton.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,constant: 7),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 14),
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),


        ])
    }
    
}

// MARK: - Public
extension PackageCardChooseServiceViewCell {
    
}

// MARK: - Action
@objc private extension PackageCardChooseServiceViewCell {
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
}

// MARK: - Private
private extension PackageCardChooseServiceViewCell {
    
}

