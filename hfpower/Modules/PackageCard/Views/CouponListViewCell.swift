//
//  CouponListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class CouponListViewCell: BaseTableViewCell<HFCouponData> {
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
        guard let item = element else { return }

        // 更新选择状态图片
        statusImageView.image = item.selected.boolValue ? UIImage(named: "selected") : UIImage(named: "unselected_c")

        // 数字格式化和标题设置
        titleLabel.text = "满\(formattedLimitAmount(for: item.limitAmount))可用"

        // 更新状态和类型相关的视图
        updateMarkViewBasedOnStatusAndType(item)

        // 设置有效期
        periodView.titleLabel.text = formatValidityPeriod(startDateString: item.startDate, endDateString: item.endDate)
    }

    // MARK: - Helper Methods

    private func formattedLimitAmount(for limitAmount: Double?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: limitAmount ?? 0)) ?? ""
    }

    private func formatValidityPeriod(startDateString: String?, endDateString: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "zh_CN")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"

        let formattedStartDate = formattedDate(from: startDateString, using: dateFormatter, outputFormatter: outputFormatter)
        let formattedEndDate = formattedDate(from: endDateString, using: dateFormatter, outputFormatter: outputFormatter)

        return "有效期：\(formattedStartDate)至\(formattedEndDate)"
    }

    private func formattedDate(from dateString: String?, using dateFormatter: DateFormatter, outputFormatter: DateFormatter) -> String {
        guard let dateString = dateString, let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        return outputFormatter.string(from: date)
    }

    private func updateMarkViewBasedOnStatusAndType(_ item: HFCouponData) {
        switch item.status {
        case 2, 3:
            markView.updateGradientColors(startColor: UIColor(hex: 0xD2D2D2FF), endColor: UIColor(hex: 0xD2D2D2FF))
        case 1:
            updateMarkViewGradientBasedOnCouponType(item)
        default:
            break
        }
        updateMarkViewBasedOnCouponType(item)
    }

    private func updateMarkViewGradientBasedOnCouponType(_ item: HFCouponData) {
        let color: (start: UIColor, end: UIColor)
        switch item.couponType {
        case 1:
            color = (UIColor(hex: 0xFFBC99FF), UIColor(hex: 0xFF8760FF))
        case 2:
            color = (UIColor(hex: 0x307CEDFF), UIColor(hex: 0x57B1F0FF))
        default:
            color = (UIColor(hex: 0xFFA5A5FF), UIColor(hex: 0xFF6C6CFF))
        }
        markView.updateGradientColors(startColor: color.start, endColor: color.end)
    }

    private func updateMarkViewBasedOnCouponType(_ item: HFCouponData) {
        let couponInfo = getCouponInfo(for: item)
        configureMarkView(title: couponInfo.title, content: couponInfo.content, labelText: couponInfo.labelText)
    }

    private func getCouponInfo(for item: HFCouponData) -> (title: String, content: String, labelText: String) {
        let discountAmountText = "\(item.discountAmount)"
        let deviceText = deviceTypeText(for: item.deviceType)
        
        switch item.couponType {
        case 1:
            return (discountAmountText, "押金券", "可抵扣\(deviceText)押金")
        case 2:
            return (discountAmountText, "租金券", "可抵扣\(deviceText)租金")
        case 3:
            return (discountAmountText, "全额券", "可抵扣\(deviceText)金额")
        case 4:
            return item.freeDepositCount != 0 ? ("免押", "免押券", "免押\(item.freeDepositCount)次") : ("免押", "免押券", "永久免押")
        case 6:
            return (discountAmountText, "满减券", "可抵扣\(deviceText)金额")
        case 7:
            return (discountAmountText, "满赠券", "可赠与\(deviceText)换电次数")
        default:
            return (discountAmountText, "免押租金券", "可抵扣\(deviceText)租金和押金")
        }
    }

    private func configureMarkView(title: String, content: String, labelText: String) {
        markView.titleLabel.text = title
        markView.unitLabel.isHidden = false
        markView.contentLabel.text = content
        contentLabel.text = labelText
        titleLabel.isHidden = false
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
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
        label.text = "满80可用"
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
    lazy var statusImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "unselected_c")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    override class func cell(with tableView: UITableView) -> CouponListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CouponListViewCell { return cell }
        return CouponListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension CouponListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(hex:0xF8F8F8FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.markView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.periodView)
        self.containerView.addSubview(self.statusImageView)

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
            self.statusImageView.widthAnchor.constraint(equalToConstant: 20),
            self.statusImageView.heightAnchor.constraint(equalToConstant: 20),
            self.statusImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor,constant: 14),
            self.statusImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -16),

        ])
    }
    
}

// MARK: - Public
extension CouponListViewCell {
    
}

// MARK: - Action
@objc private extension CouponListViewCell {
    
}

// MARK: - Private
private extension CouponListViewCell {
    
}


// MARK: - Setup
private extension CouponListViewCell.MarkView {
    
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
extension CouponListViewCell.MarkView {
    
}

// MARK: - Action
@objc private extension CouponListViewCell.MarkView {
    
}

// MARK: - Private
private extension CouponListViewCell.MarkView {
    
}
