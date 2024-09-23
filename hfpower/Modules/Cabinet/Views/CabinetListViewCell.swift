//
//  CabinetListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetListViewCell: BaseTableViewCell<HFCabinet> {
    
    // MARK: - Accessor
    override func configure() {
        self.titleLabel.text = element?.number
        self.locationLabel.text = element?.location
        self.statisticView.batteryListView.onLine = element?.onLine.boolValue ?? false
        let topThree = (element?.topThreeGrids as? [HFGridList]) ?? []
        self.statisticView.batteryListView.batteryLevels = topThree.map { CGFloat($0.batteryCapacityPercent.doubleValue)/100.0 }
        if let extraInfos = (element?.extraInfo as? [HFCabinetExtraInfo]),extraInfos.count > 0{
            self.statisticView.summaryTableView.items = extraInfos.map { [$0.largeTypeName,$0.changeCount.stringValue,$0.count.stringValue] }

        }
        self.rentStatusButton.isHidden = !(element?.rentReturnBattery.boolValue ?? true)
        self.depositStatusButton.isHidden = !(element?.rentReturnBattery.boolValue ?? true)
    }
    var navigateAction:ButtonActionBlock?
    var detailAction:ButtonActionBlock?
    var giftAction:ButtonActionBlock?{
        didSet{
            self.statisticView.giftAction = giftAction
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "金海牛能源环境产业园A座"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hex:0x262626FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var detailButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "icon_arrow_right"), for: .normal)
        button.setTitle("详情", for: .normal)
        button.setTitleColor(UIColor(hex:0x447AFEFF), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.addTarget(self, action: #selector(detailButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var businessTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "营业时间：24h"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex:0x999999FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "100m · 骑行1分钟"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex:0x333333FF)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var locationImageView: UIImageView = {
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "search_list_icon_location")
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        return locationImageView
    }()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "李沧区青山路700号"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex:0x999999FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rentStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle("可租赁", for: .normal)
        button.setTitleColor(UIColor(hex:0x165DFFFF), for: .normal)
        button.backgroundColor = UIColor(hex:0x165DFFFF).withAlphaComponent(0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var depositStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("可寄存", for: .normal)
        button.setTitleColor(UIColor(hex:0xFF7D00FF), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(hex:0xFFF7E8FF)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(hex:0x333333FF), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setImage(UIImage(named: "device_navigate"), for: .normal)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex:0xE5E6EBFF).cgColor
        button.addTarget(self, action: #selector(navigateButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var statisticView: CabinetStatisticView = {
        let view = CabinetStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var lineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> CabinetListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CabinetListViewCell { return cell }
        return CabinetListViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        navigateButton.setImagePosition(type: .imageLeft, Space: 5)
        detailButton.setImagePosition(type: .imageRight, Space: 6)
       
    }
  

}

// MARK: - Setup
private extension CabinetListViewCell {
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailButton)
        contentView.addSubview(businessTimeLabel)
        contentView.addSubview(depositStatusButton)
        contentView.addSubview(rentStatusButton)
        contentView.addSubview(rideLabel)
        contentView.addSubview(locationImageView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(statisticView)
        contentView.addSubview(navigateButton)
        contentView.addSubview(lineView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 16),
            detailButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -16),
            detailButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            detailButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16),
            businessTimeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            businessTimeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5.5),
            businessTimeLabel.trailingAnchor.constraint(equalTo:rentStatusButton.leadingAnchor, constant: -14),
            rentStatusButton.centerYAnchor.constraint(equalTo: businessTimeLabel.centerYAnchor),
            rentStatusButton.widthAnchor.constraint(equalToConstant: 41),
            rentStatusButton.heightAnchor.constraint(equalToConstant: 20),

            depositStatusButton.centerYAnchor.constraint(equalTo: businessTimeLabel.centerYAnchor),
            depositStatusButton.widthAnchor.constraint(equalToConstant: 41),
            depositStatusButton.heightAnchor.constraint(equalToConstant: 20),
            rentStatusButton.trailingAnchor.constraint(equalTo: depositStatusButton.leadingAnchor,constant: -6),
            
            
            rideLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            rideLabel.topAnchor.constraint(equalTo: businessTimeLabel.bottomAnchor, constant: 8),
            rideLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -4),
            locationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationImageView.bottomAnchor.constraint(equalTo: statisticView.topAnchor, constant: -14),
            locationImageView.widthAnchor.constraint(equalToConstant: 14),
            locationImageView.heightAnchor.constraint(equalToConstant: 14),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            locationLabel.bottomAnchor.constraint(equalTo: statisticView.topAnchor, constant: -14),
            locationLabel.trailingAnchor.constraint(equalTo: navigateButton.leadingAnchor, constant: -16),
            navigateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            navigateButton.widthAnchor.constraint(equalToConstant: 62),
            navigateButton.heightAnchor.constraint(equalToConstant: 30),
            navigateButton.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: -5),
            
            statisticView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statisticView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statisticView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -16),
            statisticView.heightAnchor.constraint(equalToConstant: 114),



            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 10),




        ])
        
    }
    
}

// MARK: - Public
extension CabinetListViewCell {
    
}

// MARK: - Action
@objc private extension CabinetListViewCell {
    @objc func navigateButtonAction(_ sender:UIButton){
        self.navigateAction?(sender)
    }
    @objc func detailButtonAction(_ sender:UIButton){
        self.detailAction?(sender)
    }
    
}

// MARK: - Private
private extension CabinetListViewCell {
    
}
