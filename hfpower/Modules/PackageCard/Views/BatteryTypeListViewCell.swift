//
//  BatteryTypeListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/12.
//

import UIKit

class BatteryTypeListViewCell: BaseTableViewCell<HFBatteryTypeList> {
    
    // MARK: - Accessor
    override func configure() {
        if let batteryType = self.element{
            self.titleLabel.text = batteryType.name
            self.contentLabel.text = batteryType.memo
        }
    }
    var sureAction:ButtonActionBlock?
    var detailAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "battery_type_default")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "60V36AH"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "续航60-80公里，适合全职及众包骑手"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex:0x666666FF)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 40)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        button.setTitle("购买套餐", for: .normal)
        button.setTitle("购买套餐", for: .highlighted)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var detailButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 74, height: 40)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "customer_icon_arrow_more")?.colorized(with: UIColor(hex:0xA0A0A0FF))?.resized(toSize: CGSize(width: 4, height: 8)), for: .normal)
        button.setImage(UIImage(named: "customer_icon_arrow_more")?.colorized(with: UIColor(hex:0xA0A0A0FF))?.resized(toSize: CGSize(width: 4, height: 8)), for: .highlighted)

        button.setTitleColor(UIColor(hex:0xA0A0A0FF), for: .normal)
        button.setTitleColor(UIColor(hex:0xA0A0A0FF), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("电池型号详情", for: .normal)
        button.setTitle("电池型号详情", for: .highlighted)
        button.addTarget(self, action: #selector(detailButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> BatteryTypeListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BatteryTypeListViewCell { return cell }
        return BatteryTypeListViewCell(style: .default, reuseIdentifier: identifier)
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
    override func layoutSubviews() {
        super.layoutSubviews()
        detailButton.setImagePosition(type: .imageRight, Space: 4)
    }
}

// MARK: - Setup
private extension BatteryTypeListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(hex:0xF6F6F6FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.iconImageView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.detailButton)
        self.containerView.addSubview(self.sureButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 70),
            iconImageView.heightAnchor.constraint(equalToConstant: 70),
            iconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 10),
            iconImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 12),
            titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor,constant: 12),
            contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor,constant: 12),
            detailButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 6),
            detailButton.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor,constant: 12),
            detailButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -14),
            
            sureButton.widthAnchor.constraint(equalToConstant: 64),
            sureButton.heightAnchor.constraint(equalToConstant: 30),
            sureButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -8),
            sureButton.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            sureButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentLabel.trailingAnchor,constant: 14),


        ])
    }
    
}

// MARK: - Public
extension BatteryTypeListViewCell {
    
}

// MARK: - Action
@objc private extension BatteryTypeListViewCell {
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
    @objc func detailButtonTapped(_ sender:UIButton){
        self.detailAction?(sender)
    }
}

// MARK: - Private
private extension BatteryTypeListViewCell {
    
}
