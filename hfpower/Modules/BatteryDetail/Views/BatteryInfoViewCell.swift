//
//  BatteryInfoViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryInfoViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatteryInfoViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatteryInfoViewCell { return cell }
        return BatteryInfoViewCell()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup
private extension BatteryInfoViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BatteryInfoViewCell {
    
}

// MARK: - Action
@objc private extension BatteryInfoViewCell {
    
}

// MARK: - Private
private extension BatteryInfoViewCell {
    
}
