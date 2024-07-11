//
//  BatteryTypeViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit

class BatteryTypeViewCell: BaseTableViewCell<BuyPackageCard> {
    
    // MARK: - Accessor
    override func configure() {
        self.iconImageView.image = UIImage(named: element?.icon ?? "")
        self.titleLabel.text = element?.title
        self.contentLabel.text = element?.subtitle
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
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
        label.text = "电池型号"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "64V36AH"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> BatteryTypeViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BatteryTypeViewCell { return cell }
        return BatteryTypeViewCell(style: .default, reuseIdentifier: identifier)
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
private extension BatteryTypeViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 12),
            iconImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 16),
            iconImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,constant: -16),
            iconImageView.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor,constant: -10),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentLabel.leadingAnchor,constant: -12),
            self.titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -14),
        ])
    }
    
}

// MARK: - Public
extension BatteryTypeViewCell {
    
}

// MARK: - Action
@objc private extension BatteryTypeViewCell {
    
}

// MARK: - Private
private extension BatteryTypeViewCell {
    
}
