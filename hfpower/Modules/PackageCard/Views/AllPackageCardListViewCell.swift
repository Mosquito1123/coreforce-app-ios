//
//  AllPackageCardListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit

class AllPackageCardListViewCell: BaseTableViewCell<HFPackageCardModel> {
    
    // MARK: - Accessor
    var useNowBlock:ButtonActionBlock?
    var perDayLabelLeading:NSLayoutConstraint!
    var perDayLabelTop:NSLayoutConstraint!

    override func configure() {
        guard let item = element else {return}
        switch item.deviceType.intValue {
        case 1:
            self.leftTopLabel.text = "租电套餐"
        default:
            self.leftTopLabel.text = "租车套餐"

        }
        self.titleLabel.text = "\(item.price)元/\(item.days)天"
        self.periodLabel.text = "有效期至：\(item.endDate)"
        let attributedText = NSAttributedString(string: "￥\(item.originalPrice)",
                                                attributes: [
                                                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor(rgba: 0xA0A0A0FF),
                                                    .font: UIFont.systemFont(ofSize: 12)
                                                ])
        self.originAmountLabel.attributedText = attributedText
        self.planPerDayLabel.text = String(format: "约合%0.2f元/天", item.price.doubleValue/item.days.doubleValue)
        switch item.status.intValue{
        case 0:
            self.useNowButton.isHidden = false
            self.statusImageView.isHidden = true
        default:
            self.statusImageView.isHidden = false
            self.useNowButton.isHidden = true
            self.statusImageView.image = item.status.intValue == 1 ? UIImage(named: "package_card_used"):UIImage(named: "package_card_expired")
        }
        self.tipsLabel.text = "限\(item.cityName)使用"
        
    }
    // MARK: - Subviews
    lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "my_package_card_background_unselected")
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
        label.text = "--元/--天"
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 22,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var originAmountLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSAttributedString(string: "￥--",
                                                attributes: [
                                                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor(rgba: 0xA0A0A0FF),
                                                    .font: UIFont.systemFont(ofSize: 12)
                                                ])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planPerDayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor(rgba: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var statusImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "package_card_used")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var refundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("已退款", for: .normal)
        button.setTitle("已退款", for: .highlighted)
        button.setTitleColor(UIColor(rgba: 0xFF6565FF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0xFF6565FF).withAlphaComponent(0.5), for: .highlighted)
        button.setImage(UIImage(named: "refund_warning"), for: .normal)
        button.setImage(UIImage(named: "refund_warning"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        label.text = "限青岛市使用"
        label.textColor = UIColor(rgba:0x666666FF)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var useNowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.tintAdjustmentMode = .automatic
        button.setTitle("立即使用", for: .normal)
        button.setTitle("立即使用", for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        button.addTarget(self, action: #selector(useNow(_:)), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> AllPackageCardListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AllPackageCardListViewCell { return cell }
        return AllPackageCardListViewCell(style: .default, reuseIdentifier: identifier)
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
        refundButton.setImagePosition(type: .imageLeft, Space: 2)
        useNowButton.setImagePosition(type: .imageRight, Space: 6)
    }

}

// MARK: - Setup
private extension AllPackageCardListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.leftTopView)
        self.leftTopView.addSubview(self.leftTopLabel)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.periodImageView)
        self.containerView.addSubview(self.periodLabel)
        self.containerView.addSubview(self.dashedLineView)
        self.containerView.addSubview(self.statusImageView)
        self.containerView.addSubview(self.useNowButton)
        self.containerView.addSubview(self.refundButton)
        self.containerView.addSubview(self.originAmountLabel)
        self.containerView.addSubview(self.planPerDayLabel)
        self.containerView.addSubview(self.tipsLabel)
    }
    
    private func setupLayout() {
        perDayLabelTop = planPerDayLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20)
        perDayLabelLeading = planPerDayLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,constant: 10)
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
            self.originAmountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            self.originAmountLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            perDayLabelTop,
            perDayLabelLeading,

            refundButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 6),
            refundButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -12),
            refundButton.widthAnchor.constraint(equalToConstant: 47),
            refundButton.heightAnchor.constraint(equalToConstant: 12),

            //立即使用按钮
            useNowButton.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 26),
            useNowButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            useNowButton.widthAnchor.constraint(equalToConstant: 82),
            useNowButton.heightAnchor.constraint(equalToConstant: 30),
            
            //使用状态图标
            statusImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 30),
            statusImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -11),
            statusImageView.widthAnchor.constraint(equalToConstant: 61.5),
            statusImageView.heightAnchor.constraint(equalToConstant: 47),


        ])
    }
    
}

// MARK: - Public
extension AllPackageCardListViewCell {
    
}

// MARK: - Action
@objc private extension AllPackageCardListViewCell {
    @objc func useNow(_ sender:UIButton){
        self.useNowBlock?(sender)
    }
}

// MARK: - Private
private extension AllPackageCardListViewCell {
    
}
