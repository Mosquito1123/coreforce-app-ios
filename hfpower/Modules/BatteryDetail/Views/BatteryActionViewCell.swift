//
//  BatteryActionViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryActionViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
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
    var element:BatteryActionItem?{
        didSet{
            submitButton.setTitle(element?.name, for: .normal)
            submitButton.setTitle(element?.name, for: .highlighted)
            submitButton.setImage(UIImage(named: element?.icon ?? "device_renewal"), for: .normal)
            submitButton.setImage(UIImage(named: element?.icon ?? "device_renewal"), for: .highlighted)
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
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("续费", for: .normal)
        button.setTitle("续费", for: .highlighted)
        button.setTitleColor(UIColor(hex:0x4D4D4DFF), for: .normal)
        button.setTitleColor(UIColor(hex:0x4D4D4DFF).withAlphaComponent(0.5), for: .highlighted)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "device_renewal"), for: .normal)
        button.setImage(UIImage(named: "device_renewal"), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .medium)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatteryActionViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatteryActionViewCell { return cell }
        return BatteryActionViewCell()
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
    override func layoutSubviews() {
        super.layoutSubviews()
        submitButton.setImagePosition(type: .imageLeft, Space: 9)
    }
}

// MARK: - Setup
private extension BatteryActionViewCell {
    
    private func setupSubviews() {
        self.contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(submitButton)
        

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Submit button constraints
            submitButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            submitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

           
        ])
    }
    
}

// MARK: - Public
extension BatteryActionViewCell {
    
}

// MARK: - Action
@objc private extension BatteryActionViewCell {
    
}

// MARK: - Private
private extension BatteryActionViewCell {
    
}
