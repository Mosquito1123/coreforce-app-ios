//
//  FirstContentActivityCollectionViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/10/15.
//

import UIKit

class FirstContentActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    // 懒加载视图
    lazy var leftTopView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        view.translatesAutoresizingMaskIntoConstraints = false

        // 创建渐变层
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [
            UIColor(red: 246/255.0, green: 120/255.0, blue: 109/255.0, alpha: 1.0).cgColor,
            UIColor(red: 235/255.0, green: 76/255.0, blue: 86/255.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0, 1]

        // 设置圆角
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 6, height: 6))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        gradientLayer.mask = maskLayer

        view.layer.addSublayer(gradientLayer)
        return view
    }()

    lazy var leftTopLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        label.text = ""
        label.textAlignment = .center
        label.textColor = UIColor(white: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "battery_type_default")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "--天"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planUnitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.text = "￥"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont(name: "DIN Alternate Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "999"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont(name: "DIN Alternate Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var originAmountLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSAttributedString(string: "￥--",
                                                attributes: [
                                                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1),
                                                    .font: UIFont.systemFont(ofSize: 12)
                                                ])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planPerMonthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> FirstContentActivityCollectionViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FirstContentActivityCollectionViewCell { return cell }
        return FirstContentActivityCollectionViewCell()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupLayout()
    }

}

// MARK: - Setup
private extension FirstContentActivityCollectionViewCell {
    
    private func setupSubviews() {
        contentView.addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(daysLabel)
        containerView.addSubview(planUnitLabel)
        containerView.addSubview(planAmountLabel)
        containerView.addSubview(originAmountLabel)
        containerView.addSubview(originAmountLabel)
        containerView.addSubview(planPerMonthLabel)
        containerView.addSubview(leftTopView)
        containerView.addSubview(leftTopLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            leftTopView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            leftTopView.topAnchor.constraint(equalTo: containerView.topAnchor),

            leftTopLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            leftTopLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            daysLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            daysLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),

            planAmountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 10),
            planAmountLabel.topAnchor.constraint(equalTo: daysLabel.bottomAnchor, constant: 10),

            planUnitLabel.centerYAnchor.constraint(equalTo: planAmountLabel.centerYAnchor),
            planUnitLabel.trailingAnchor.constraint(equalTo: planAmountLabel.leadingAnchor),

            originAmountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            originAmountLabel.topAnchor.constraint(equalTo: planAmountLabel.bottomAnchor, constant: 10),

            planPerMonthLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            planPerMonthLabel.topAnchor.constraint(equalTo: originAmountLabel.bottomAnchor, constant: 10)
        ])
    }
    
}

// MARK: - Public
extension FirstContentActivityCollectionViewCell {
    
}

// MARK: - Action
@objc private extension FirstContentActivityCollectionViewCell {
    
}

// MARK: - Private
private extension FirstContentActivityCollectionViewCell {
    
}
