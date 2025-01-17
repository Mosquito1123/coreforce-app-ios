//
//  FeeDetailViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/1.
//

import UIKit
class FeeDetailSecondViewCell: BaseTableViewCell<BuyPackageCard> {
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var batteryRentLabel: UILabel!
    private var batteryRentDetailLabel: UILabel!
    private var batteryRentAmountLabel: UILabel!
    private var selectedPlanLabel: UILabel!
    private var selectedPlanDetailLabel: UILabel!

    // MARK: - Accessor
    override func configure() {
        self.titleLabel.text = element?.title
        configureBatteryRentLabel()
        
        guard let packageCard = element?.packageCard else { return }
        
        self.batteryRentAmountLabel.text = String(format: "%0.2f元", packageCard.price.doubleValue)
        self.selectedPlanDetailLabel.text = "\(String(format: "%0.2f元", packageCard.price.doubleValue))/\(packageCard.days)天"
    }

    private func configureBatteryRentLabel() {
        if let _ = element?.bikeDetail {
            self.batteryRentLabel.text = "电车租金"
        } else {
            self.batteryRentLabel.text = "电池租金"
        }
    }

    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }

    override class func cell(with tableView: UITableView) -> FeeDetailSecondViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FeeDetailSecondViewCell { return cell }
        return FeeDetailSecondViewCell(style: .default, reuseIdentifier: identifier)
    }

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()  // 移动label的初始化到setupSubviews
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup
private extension FeeDetailSecondViewCell {
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(white: 0.96, alpha: 1)
        contentView.addSubview(containerView)
        
        // 在这里初始化 UILabel 实例
        titleLabel = createLabel(text: "费用结算", fontSize: 16, weight: .medium, textColor: UIColor(hex: 0x333333FF))
        batteryRentLabel = createLabel(text: "--租金", fontSize: 16, textColor: UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1))
        batteryRentDetailLabel = createLabel(fontSize: 13, textColor: UIColor(red: 255/255, green: 58/255, blue: 58/255, alpha: 1))
        batteryRentAmountLabel = createRightAlignedLabel(text: "--元", fontSize: 16, textColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1))
        selectedPlanLabel = createLabel(text: "已选套餐", fontSize: 16, textColor: UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1))
        selectedPlanDetailLabel = createRightAlignedLabel(text: "--元/--天", fontSize: 16, textColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1))

        // 将所有label添加到 containerView 中
        [titleLabel, batteryRentLabel, batteryRentDetailLabel, batteryRentAmountLabel, selectedPlanLabel, selectedPlanDetailLabel].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            batteryRentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            batteryRentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            
            batteryRentDetailLabel.leadingAnchor.constraint(equalTo: batteryRentLabel.trailingAnchor, constant: 11),
            batteryRentDetailLabel.centerYAnchor.constraint(equalTo: batteryRentLabel.centerYAnchor),
            
            batteryRentAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            batteryRentAmountLabel.centerYAnchor.constraint(equalTo: batteryRentLabel.centerYAnchor),
            
            selectedPlanLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            selectedPlanLabel.topAnchor.constraint(equalTo: batteryRentLabel.bottomAnchor, constant: 16),
            selectedPlanLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18),
            
            selectedPlanDetailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            selectedPlanDetailLabel.centerYAnchor.constraint(equalTo: selectedPlanLabel.centerYAnchor)
        ])
    }

    // Helper methods to create UILabels
    private func createLabel(text: String = "", fontSize: CGFloat, weight: UIFont.Weight = .regular, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createRightAlignedLabel(text: String = "", fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = createLabel(text: text, fontSize: fontSize, textColor: textColor)
        label.textAlignment = .right
        return label
    }
}


class FeeDetailViewCell: BaseTableViewCell<BuyPackageCard> {
    
    // MARK: - Accessor
    var showCouponAction:(()->())?
    override func configure() {
        self.titleLabel.text = element?.title
        if let bikeDetail = element?.bikeDetail{
            self.batteryDepositLabel.text = "电车押金"
            self.batteryDepositAmountLabel.text = "\(bikeDetail.planDeposit)元"
            self.batteryRentLabel.text = "电车租金"
        }else{
            if let batteryType = element?.batteryType{
                self.batteryRentLabel.text = "电池租金"
                self.batteryDepositLabel.text = "电池押金"
                let depositAmount = batteryType.batteryDeposit
                self.batteryDepositAmountLabel.text = "\(depositAmount)元"
            }else if let batteryDetail = element?.batteryDetail{
                self.batteryRentLabel.text = "电池租金"
                self.batteryDepositLabel.text = "电池押金"
                let depositAmount = batteryDetail.batteryDeposit
                self.batteryDepositAmountLabel.text = "\(depositAmount)元"
            }
            
        }
        guard let packageCard = element?.packageCard else { return  }
        
        self.batteryRentDetailLabel.text = "\(String(format: "约合%0.2f元/天", packageCard.price.doubleValue/packageCard.days.doubleValue)) x\(packageCard.days)"
        self.batteryRentAmountLabel.text = String(format: "%0.2f元", packageCard.price.doubleValue)
        self.selectedPlanDetailLabel.text = "\(String(format: "%0.2f元", packageCard.price.doubleValue))/\(packageCard.days)天"
        self.couponDetailLabel.text = element?.coupon?.name ?? ""
        


    }
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
        label.text = "费用结算"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let batteryRentLabel: UILabel = {
        let label = UILabel()
        label.text = "--租金"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let batteryRentDetailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 255/255, green: 58/255, blue: 58/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let batteryRentAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "--元"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let batteryDepositLabel: UILabel = {
        let label = UILabel()
        label.text = "--押金"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let batteryDepositAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "--元"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let selectedPlanLabel: UILabel = {
        let label = UILabel()
        label.text = "已选套餐"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedPlanDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "--元/--天"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    private let couponView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let couponLabel: UILabel = {
        let label = UILabel()
        label.text = "优惠券"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let couponDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "       "
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let couponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_right")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> FeeDetailViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FeeDetailViewCell { return cell }
        return FeeDetailViewCell(style: .default, reuseIdentifier: identifier)
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
private extension FeeDetailViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(containerView)
        containerView.addSubview(self.titleLabel)
        containerView.addSubview(batteryRentLabel)
        containerView.addSubview(batteryRentDetailLabel)
        containerView.addSubview(batteryRentAmountLabel)
        containerView.addSubview(batteryDepositLabel)
        containerView.addSubview(batteryDepositAmountLabel)
        containerView.addSubview(selectedPlanLabel)
        containerView.addSubview(selectedPlanDetailLabel)
        // 添加 couponView 和它的子视图
        containerView.addSubview(couponView)
        couponView.addSubview(couponLabel)
        couponView.addSubview(couponDetailLabel)
        couponView.addSubview(couponImageView)
        
        // 添加点击手势到 couponView
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        couponView.addGestureRecognizer(tap)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -6),
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            
            batteryRentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            batteryRentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            
            batteryRentDetailLabel.leadingAnchor.constraint(equalTo: batteryRentLabel.trailingAnchor, constant: 11),
            batteryRentDetailLabel.centerYAnchor.constraint(equalTo: batteryRentLabel.centerYAnchor),
            
            batteryRentAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            batteryRentAmountLabel.centerYAnchor.constraint(equalTo: batteryRentLabel.centerYAnchor),
            
            batteryDepositLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            batteryDepositLabel.topAnchor.constraint(equalTo: batteryRentLabel.bottomAnchor, constant: 16),
            
            batteryDepositAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            batteryDepositAmountLabel.centerYAnchor.constraint(equalTo: batteryDepositLabel.centerYAnchor),
            
            selectedPlanLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            selectedPlanLabel.topAnchor.constraint(equalTo: batteryDepositLabel.bottomAnchor, constant: 16),
            
            selectedPlanDetailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            selectedPlanDetailLabel.centerYAnchor.constraint(equalTo: selectedPlanLabel.centerYAnchor),
            
            // 布局 couponView 和其子视图
            couponView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            couponView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            couponView.topAnchor.constraint(equalTo: selectedPlanLabel.bottomAnchor, constant: 16),
            couponView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18),
            couponView.heightAnchor.constraint(equalToConstant: 30),
            couponLabel.leadingAnchor.constraint(equalTo: couponView.leadingAnchor),
            couponLabel.centerYAnchor.constraint(equalTo: couponView.centerYAnchor),
            
            couponDetailLabel.trailingAnchor.constraint(lessThanOrEqualTo: couponImageView.leadingAnchor, constant: -14),
            couponDetailLabel.centerYAnchor.constraint(equalTo: couponView.centerYAnchor),
            
            couponImageView.trailingAnchor.constraint(equalTo: couponView.trailingAnchor),
            couponImageView.centerYAnchor.constraint(equalTo: couponView.centerYAnchor),
            couponImageView.widthAnchor.constraint(equalToConstant: 6),
            couponImageView.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
}

// MARK: - Public
extension FeeDetailViewCell {
    
}

// MARK: - Action
@objc private extension FeeDetailViewCell {
    @objc func tapAction() {
        self.showCouponAction?()
    }
}

// MARK: - Private
private extension FeeDetailViewCell {
    
}
