//
//  MyPackageCardListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class MyPackageCardListViewCell: BaseTableViewCell<PackageCard> {
    
    // MARK: - Accessor
    override func configure() {
        guard let item = element else {return}
    
    }
    // MARK: - Subviews
    lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "my_package_card_background_unselected")
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var leftTopLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        label.text = "已购套餐"
        label.textAlignment = .center
        label.textColor = UIColor(rgba: 0x447AFEFF)
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var leftTopView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tip_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "299元/30天"
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 22,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var statusImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "unselected")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var periodImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "period")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "有效期至：2023.05.06 12:5"
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var dashedLineView: DashedLineView = {
        let view = DashedLineView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var tipsLabel:UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor(rgba:0x666666FF)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> MyPackageCardListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageCardListViewCell { return cell }
        return MyPackageCardListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension MyPackageCardListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.leftTopView)
        self.leftTopView.addSubview(self.leftTopLabel)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.periodImageView)
        self.containerView.addSubview(self.periodLabel)
        self.containerView.addSubview(self.dashedLineView)
        self.containerView.addSubview(self.statusImageView)
        self.containerView.addSubview(self.tipsLabel)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            self.leftTopLabel.leadingAnchor.constraint(equalTo: self.leftTopView.leadingAnchor,constant: 10),
            self.leftTopLabel.topAnchor.constraint(equalTo: self.leftTopView.topAnchor,constant: 3),
        ])
        NSLayoutConstraint.activate([
            self.leftTopView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.leftTopView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 24),
            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 22),
            self.periodLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 7),
            self.periodLabel.leadingAnchor.constraint(equalTo: self.periodImageView.trailingAnchor,constant: 4),
            self.periodImageView.widthAnchor.constraint(equalToConstant: 14),
            self.periodImageView.heightAnchor.constraint(equalToConstant: 14),
            self.periodImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            self.periodImageView.centerYAnchor.constraint(equalTo: self.periodLabel.centerYAnchor),
            self.dashedLineView.topAnchor.constraint(equalTo: self.periodLabel.bottomAnchor, constant: 13),
            self.dashedLineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.dashedLineView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.dashedLineView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.tipsLabel.topAnchor.constraint(equalTo: self.periodLabel.bottomAnchor, constant: 25),
            self.tipsLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            self.tipsLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -22),
            self.statusImageView.widthAnchor.constraint(equalToConstant: 20),
            self.statusImageView.heightAnchor.constraint(equalToConstant: 20),
            self.statusImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 21),
            self.statusImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -13),


            



        ])
    }
    
}

// MARK: - Public
extension MyPackageCardListViewCell {
    
}

// MARK: - Action
@objc private extension MyPackageCardListViewCell {
    
}

// MARK: - Private
private extension MyPackageCardListViewCell {
    
}
