//
//  AllCouponListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit

class AllCouponListViewCell: BaseTableViewCell<Coupon> {
    class PeriodView:UIView{
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "有效期至：2023.05.06 12:5"
            label.textColor = UIColor(rgba:0x333333FF)
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.cornerRadius = 1
            self.backgroundColor = UIColor(rgba:0xF9F9FBFF)
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
            label.textColor = UIColor(rgba:0xFFFFFFFF)
            label.font = UIFont(name: "DIN Alternate Bold", size: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = UIColor(rgba:0xFFFFFFFF)
            label.font = UIFont(name: "DIN Alternate Bold", size: 22)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = UIColor(rgba:0xFFFFFFFF)
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
        let status = item.status ?? 0
        if status == 0{
            statusButton.isHidden = false
            statusButton.setTitle("已使用", for: .normal)
            markView.updateGradientColors(startColor: UIColor(rgba: 0xD2D2D2FF), endColor: UIColor(rgba: 0xD2D2D2FF))
        }else if status == 1{
            statusButton.isHidden = true
        }else if status == 2{
            statusButton.isHidden = false
            statusButton.setTitle("已过期", for: .normal)
            markView.updateGradientColors(startColor: UIColor(rgba: 0xD2D2D2FF), endColor: UIColor(rgba: 0xD2D2D2FF))


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
        label.text = "满80可用"
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "限青岛市使用，新人特惠、限时活动不可用"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintAdjustmentMode = .automatic
        button.setTitle("已过期", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderColor = UIColor(rgba: 0xA0A0A0FF).cgColor
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
        self.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
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