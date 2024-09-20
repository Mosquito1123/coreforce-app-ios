//
//  PersonalInfoListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class PersonalInfoListViewCell: BaseTableViewCell<PersonalInfo> {
    
    // MARK: - Accessor
    var iconWidth:NSLayoutConstraint!
    var iconHeight:NSLayoutConstraint!
    override func configure() {
        self.titleLabel.text = element?.title
        self.contentLabel.text = element?.content
        if element?.isEditable == true{
            self.contentLabel.textColor = UIColor(hex:0xF53F3FFF)
        }else if element?.isEditable == false{
            self.contentLabel.textColor = UIColor(hex:0x56C386FF)
        }else{
            self.contentLabel.textColor = UIColor(hex:0x333333FF)
        }
        if element?.isNext == true{
            iconImageView.isHidden = false
            iconWidth.constant = 6
            iconHeight.constant = 12
            self.layoutIfNeeded()
        }else{
            iconImageView.isHidden = true
            iconWidth.constant = 0
            iconHeight.constant = 0
            self.layoutIfNeeded()
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 14)
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
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PersonalInfoListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalInfoListViewCell { return cell }
        return PersonalInfoListViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //初始化
        setupSubviews()
        setupLayout()
    }

}

// MARK: - Setup
private extension PersonalInfoListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.iconImageView)

    }
    
    private func setupLayout() {
        iconWidth = iconImageView.widthAnchor.constraint(equalToConstant: 6)
        iconHeight = iconImageView.heightAnchor.constraint(equalToConstant: 12)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -14),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentLabel.leadingAnchor,constant: -14),
            contentLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor,constant: -6),
            iconWidth,
            iconHeight,
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -12)
            


        ])
    }
    
}

// MARK: - Public
extension PersonalInfoListViewCell {
    
}

// MARK: - Action
@objc private extension PersonalInfoListViewCell {
    
}

// MARK: - Private
private extension PersonalInfoListViewCell {
    
}
