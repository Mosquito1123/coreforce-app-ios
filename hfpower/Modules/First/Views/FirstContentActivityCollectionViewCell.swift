//
//  FirstContentActivityCollectionViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/10/15.
//

import UIKit

class FirstContentActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    var model: HFPackageCardModel? {
        didSet {
            guard let model = model else { return }
           
            
//            if model.tag == "" {
//                leftTopView.isHidden = true
//                leftTopLabel.isHidden = true
//            } else {
//                leftTopView.isHidden = false
//                leftTopLabel.isHidden = false
//            }
            leftTopLabel.text = "新人专享"
            daysLabel.text = "\(model.days)天"
            let nf = NumberFormatter()
            nf.maximumFractionDigits = 2
            nf.minimumFractionDigits = 0
            planAmountLabel.text = nf.string(from: model.price )
            let mf = NSMutableAttributedString()
            let attributedTextTitle = NSAttributedString(string: "原价：",
                                                    attributes: [
                                                        .foregroundColor: UIColor(hex: 0xAAAAAAFF),
                                                        .font: UIFont.systemFont(ofSize: 12)
                                                    ])
            mf.append(attributedTextTitle)

            let attributedText = NSAttributedString(string: "\(nf.string(from: model.originalPrice ) ?? "0")元",
                                                    attributes: [
                                                        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                        .foregroundColor: UIColor(hex: 0xAAAAAAFF),
                                                        .font: UIFont.systemFont(ofSize: 12)
                                                    ])
            mf.append(attributedText)
            originAmountLabel.attributedText = mf
            let perMonthNumber = (model.price.doubleValue  )/(model.days.doubleValue )
            planPerMonthLabel.text = "\(nf.string(from: NSNumber(value: perMonthNumber)) ?? "0")元/天"

        }
    }
    // MARK: - Subviews
    lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "first_package_card_background")
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    // 懒加载视图
    /*
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
*/
    lazy var leftTopView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "first_left_top_background")
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.text = "--"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont(name: "DIN Alternate Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dashedLineView: DashedLineView = {
        let view = DashedLineView()
        view.backgroundColor = .white
        view.dashColor = UIColor(hex: 0xBDC1CCFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var originAmountLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSAttributedString(string: "￥--",
                                                attributes: [
                                                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor(hex: 0xAAAAAAFF),
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
        label.textColor = UIColor(hex: 0xF5746BFF)
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> FirstContentActivityCollectionViewCell {
        let identifier = cellIdentifier()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? FirstContentActivityCollectionViewCell else { return FirstContentActivityCollectionViewCell() }
        return cell
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
        self.contentView.backgroundColor = .clear
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
        containerView.addSubview(dashedLineView)
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
            planPerMonthLabel.topAnchor.constraint(equalTo: originAmountLabel.bottomAnchor, constant: 10),
            self.dashedLineView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -56),
            self.dashedLineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.dashedLineView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 7),
            self.dashedLineView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -7),
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
