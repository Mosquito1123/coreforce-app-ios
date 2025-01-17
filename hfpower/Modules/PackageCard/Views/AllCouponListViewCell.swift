//
//  AllCouponListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit

class AllCouponListViewCell: BaseTableViewCell<HFCouponData> {
    class PeriodView:UIView{
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "有效期至：--"
            label.textColor = UIColor(hex:0x333333FF)
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.cornerRadius = 1
            self.backgroundColor = UIColor(hex:0xF9F9FBFF)
            self.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 6),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 6),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -6),
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -6),

            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    class MarkView: UIView {
        
        // MARK: - Accessor
        private var gradientLayer: CAGradientLayer!
        
        // MARK: - Subviews
        lazy var unitLabel: UILabel = {
            let label = UILabel()
            label.text = "¥"
            label.numberOfLines = 0
            label.textColor = UIColor(hex:0xFFFFFFFF)
            label.font = UIFont(name: "DIN Alternate Bold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = UIColor(hex:0xFFFFFFFF)
            label.font = UIFont(name: "DIN Alternate Bold", size: 22)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = UIColor(hex:0xFFFFFFFF)
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        // MARK: - Lifecycle
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupGradientLayer(startColor: UIColor(red: 0.19, green: 0.49, blue: 0.93, alpha: 1),
                               endColor: UIColor(red: 0.34, green: 0.69, blue: 0.94, alpha: 1))
            setupSubviews()
            setupLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        private func setupGradientLayer(startColor: UIColor, endColor: UIColor) {
            gradientLayer = CAGradientLayer()
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.locations = [0, 1]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.layer.cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = self.bounds
        }
        
        // 更新渐变颜色的方法
        func updateGradientColors(startColor: UIColor, endColor: UIColor) {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    // MARK: - Accessor
    override func configure() {
        guard let item = element else {return}
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let formattedString = "满\(numberFormatter.string(from: NSNumber(value: element?.limitAmount ?? 0)) ?? "")可用"
        self.titleLabel.text = formattedString
        let couponType = item.couponType 
        
        let status = item.status 
        if status == 2{
            statusButton.isHidden = false
            statusButton.setTitle("已使用", for: .normal)
            markView.updateGradientColors(startColor: UIColor(hex:0xD2D2D2FF), endColor: UIColor(hex:0xD2D2D2FF))
        }else if status == 1{
            statusButton.isHidden = true
            switch couponType {
            case 1://押金券
                markView.updateGradientColors(startColor: UIColor(hex:0xFFBC99FF), endColor: UIColor(hex:0xFF8760FF))
            case 2://租金券
                markView.updateGradientColors(startColor: UIColor(hex:0x307CEDFF), endColor: UIColor(hex:0x57B1F0FF))
            default://其他
                markView.updateGradientColors(startColor: UIColor(hex:0xFFA5A5FF), endColor: UIColor(hex:0xFF6C6CFF))
            }
        }else if status == 3{
            statusButton.isHidden = false
            statusButton.setTitle("已过期", for: .normal)
            markView.updateGradientColors(startColor: UIColor(hex:0xD2D2D2FF), endColor: UIColor(hex:0xD2D2D2FF))


        }
        // 创建日期格式化器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 假设日期字符串是 ISO 8601 格式
        dateFormatter.locale = Locale(identifier: "zh_CN") // 根据需要设置区域

        // 输出日期格式，只显示年月日
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd" // 只显示年月日
        var formattedStartDate = ""
        var formattedEndDate = ""
        // 将字符串日期转换为 Date 并格式化为 "yyyy-MM-dd"
        if let startDateString = element?.startDate,
           let startDate = dateFormatter.date(from: startDateString) {
            formattedStartDate = outputFormatter.string(from: startDate)
        }

        if let endDateString = element?.endDate,
           let endDate = dateFormatter.date(from: endDateString) {
            formattedEndDate = outputFormatter.string(from: endDate)
        }

        // 构建有效期字符串
        let validityPeriod = "有效期：\(formattedStartDate)至\(formattedEndDate)"

        periodView.titleLabel.text = validityPeriod
        switch couponType {
        case 1://
            markView.titleLabel.text = "\(item.discountAmount)"
            markView.unitLabel.isHidden = false
            markView.contentLabel.text = "押金券"
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))押金"
            titleLabel.isHidden = false
        case 2://
            markView.titleLabel.text = "\(item.discountAmount )"
            markView.unitLabel.isHidden = false
            markView.contentLabel.text = "租金券"
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))租金"
            titleLabel.isHidden = false
        case 3://
            markView.titleLabel.text = "\(item.discountAmount )"
            markView.contentLabel.text = "全额券"
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))金额"
            titleLabel.isHidden = false
        case 4://
            markView.titleLabel.text = "免押"
            markView.unitLabel.isHidden = true
            markView.contentLabel.text = "免押券"
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))押金"
            titleLabel.text = (item.freeDepositCount != 0) ? "免押\(item.freeDepositCount)次":"永久免押"
            titleLabel.isHidden = false
        
        case 6://
            markView.titleLabel.text = "\(item.discountAmount )"
            markView.contentLabel.text = "满减券"
            markView.unitLabel.isHidden = false
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))金额"
            titleLabel.isHidden = false
        case 7://
            markView.titleLabel.text = "\(item.discountAmount )"
            markView.contentLabel.text = "满赠券"
            markView.unitLabel.isHidden = false
            contentLabel.text = "可赠与\(deviceTypeText(for: element?.deviceType))换电次数"
            titleLabel.isHidden = false
        default://其他
            markView.titleLabel.text = "\(item.discountAmount )"
            markView.contentLabel.text = "免押租金券"
            markView.unitLabel.isHidden = false
            contentLabel.text = "可抵扣\(deviceTypeText(for: element?.deviceType))租金和押金"
            titleLabel.isHidden = false

        }
    }
    private func deviceTypeText(for deviceType: Int?) -> String {
        switch deviceType {
        case 1: return "电池"
        case 4: return "机车"
        default: return "换电卡"
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var markView:MarkView = {
        let view = MarkView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex:0x666666FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintAdjustmentMode = .automatic
        button.setTitle("--", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderColor = UIColor(hex:0xA0A0A0FF).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        // 添加点击事件（可选）
        
        
        return button
    }()
    lazy var periodView:PeriodView = {
        let view = PeriodView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> AllCouponListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AllCouponListViewCell { return cell }
        return AllCouponListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension AllCouponListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.markView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.periodView)
        self.containerView.addSubview(self.statusButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            markView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 12),
            markView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 12),
            markView.widthAnchor.constraint(equalToConstant: 80),
            markView.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: self.markView.trailingAnchor, constant: 12.5),
            titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 18),
            contentLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            periodView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            periodView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -12),
            periodView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor,constant: 9),
            periodView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -12),
            statusButton.widthAnchor.constraint(equalToConstant: 60),
            statusButton.heightAnchor.constraint(equalToConstant: 30),
            statusButton.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 12),
            statusButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -14),

        ])
    }
    
}

// MARK: - Public
extension AllCouponListViewCell {
    
}

// MARK: - Action
@objc private extension AllCouponListViewCell {
    
}

// MARK: - Private
private extension AllCouponListViewCell {
    
}
// MARK: - Setup
private extension AllCouponListViewCell.MarkView {
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(unitLabel)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            unitLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
}

// MARK: - Public
extension AllCouponListViewCell.MarkView {
    
}

// MARK: - Action
@objc private extension AllCouponListViewCell.MarkView {
    
}

// MARK: - Private
private extension AllCouponListViewCell.MarkView {
    
}
