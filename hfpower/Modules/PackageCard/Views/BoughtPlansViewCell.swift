//
//  BoughtPlansViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/1.
//

import UIKit

class BoughtPlansViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "已购套餐"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(named: "333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "299元/30天"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> BoughtPlansViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoughtPlansViewCell { return cell }
        return BoughtPlansViewCell(style: .default, reuseIdentifier: identifier)
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
private extension BoughtPlansViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(iconImageView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 14),
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 18),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -18),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentLabel.leadingAnchor,constant: -12),
            self.titleLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor,constant: -8),
            self.iconImageView.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            self.iconImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -22),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 6),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 12),

            
        ])
    }
    
}

// MARK: - Public
extension BoughtPlansViewCell {
    
}

// MARK: - Action
@objc private extension BoughtPlansViewCell {
    
}

// MARK: - Private
private extension BoughtPlansViewCell {
    
}
