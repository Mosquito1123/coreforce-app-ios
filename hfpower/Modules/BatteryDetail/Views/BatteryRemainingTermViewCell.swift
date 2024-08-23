//
//  BatteryRemainingTermViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryRemainingTermViewCell: UICollectionViewCell {
    class BottomView:UIView{
        var getPackageCardBlock:ButtonActionBlock?
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "购买套餐更优惠"
            label.textColor = UIColor(rgba:0xC96518FF)
            label.font = UIFont.systemFont(ofSize: 12,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "device_gift")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        lazy var submitButton: UIButton = {
            let button = UIButton(type: .custom)
            button.tintAdjustmentMode = .automatic
            button.setTitle("立即购买", for: .normal)
            button.setTitle("立即购买", for: .highlighted)
            button.setTitleColor(UIColor(rgba: 0xC96518FF), for: .normal)
            button.setTitleColor(UIColor(rgba: 0xC96518FF).withAlphaComponent(0.5), for: .highlighted)
            button.setImage(UIImage(named: "device_ic_arrow"), for: .normal)
            button.setImage(UIImage(named: "device_ic_arrow"), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
            button.addTarget(self, action: #selector(getCoupon(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
        @objc func getCoupon(_ sender:UIButton){
            self.getPackageCardBlock?(sender)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            submitButton.setImagePosition(type: .imageRight, Space: 6)
            
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
      
            
            // fillCode
            self.backgroundColor = UIColor(rgba: 0xFEBF44FF).withAlphaComponent(0.1)
            
           
            self.layer.cornerRadius = 12
            self.addSubview(iconImageView)
            self.addSubview(titleLabel)
            self.addSubview(submitButton)
            NSLayoutConstraint.activate([
                iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
                iconImageView.widthAnchor.constraint(equalToConstant: 12),
                iconImageView.heightAnchor.constraint(equalToConstant: 12),

                iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor,constant: 4),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 17.5),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16.5),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.submitButton.leadingAnchor,constant: -14),
                submitButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -22),
                submitButton.widthAnchor.constraint(equalToConstant: 80),
                submitButton.heightAnchor.constraint(equalToConstant: 20),



            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    // MARK: - Accessor
    var cornerType:BaseCellCornerType = .all{
        didSet{
            switch cornerType {
            case .first:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .last:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .all:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .none:
                self.containerView.layer.cornerRadius = 0
                
            }
        }
    }
    var element:BatteryRemainingTerm?{
        didSet{
            self.titleLabel.text = element?.title
            self.contentLabel.text = element?.content
            self.contentLabel.textColor = element?.overdueOrExpiringSoon == true ? UIColor(rgba: 0xFF2F1DFF):UIColor(rgba: 0x333333FF)
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "剩余租期"
        label.textColor = UIColor(rgba: 0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "17小时"
        label.textColor = UIColor(rgba: 0xFF2F1DFF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgba: 0xFF3A3AFF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatteryRemainingTermViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatteryRemainingTermViewCell { return cell }
        return BatteryRemainingTermViewCell()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension BatteryRemainingTermViewCell {
    
    private func setupSubviews() {
        self.contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(extraLabel)
        containerView.addSubview(bottomView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0.5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -0.5),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor,constant: -16),
            // Content label constraints
            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            contentLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor,constant: -16),
             
            extraLabel.trailingAnchor.constraint(equalTo: contentLabel.leadingAnchor, constant: -10),
            extraLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 12),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -12),
            bottomView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -11)
        ])
    }
    
}

// MARK: - Public
extension BatteryRemainingTermViewCell {
    
}

// MARK: - Action
@objc private extension BatteryRemainingTermViewCell {
    
}

// MARK: - Private
private extension BatteryRemainingTermViewCell {
    
}
