//
//  BikeStatusViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/20.
//

import UIKit

class BikeStatusViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hflogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("1", for: .normal)
        button.setTitle("1", for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(rgba:0x333333FF), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setImage(UIImage(named: "navigate"), for: .normal)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(rgba:0xE5E6EBFF).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BikeStatusViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BikeStatusViewCell { return cell }
        return BikeStatusViewCell()
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
private extension BikeStatusViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BikeStatusViewCell {
    
}

// MARK: - Action
@objc private extension BikeStatusViewCell {
    
}

// MARK: - Private
private extension BikeStatusViewCell {
    
}
