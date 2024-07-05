//
//  CustomerServicePagerItemViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/4.
//

import UIKit

class CustomerServicePagerItemViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var element:String?{
        didSet{
            
        }
    }
    // MARK: - Subviews
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0xFF9F18FF)
        label.font = UIFont.systemFont(ofSize: 15,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "customer_icon_arrow_more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> CustomerServicePagerItemViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerServicePagerItemViewCell { return cell }
        return CustomerServicePagerItemViewCell(style: .default, reuseIdentifier: identifier)
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
private extension CustomerServicePagerItemViewCell {
    
    private func setupSubviews() {
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(rightIconImageView)


    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            numberLabel.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor,constant: -14.5),
            numberLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.rightIconImageView.leadingAnchor,constant: -14),
            rightIconImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            rightIconImageView.widthAnchor.constraint(equalToConstant: 6.5),
            rightIconImageView.heightAnchor.constraint(equalToConstant: 12),
            rightIconImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)



        ])
    }
    
}

// MARK: - Public
extension CustomerServicePagerItemViewCell {
    
}

// MARK: - Action
@objc private extension CustomerServicePagerItemViewCell {
    
}

// MARK: - Private
private extension CustomerServicePagerItemViewCell {
    
}
