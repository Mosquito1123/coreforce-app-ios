//
//  BatteryStatusViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryStatusViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatteryStatusViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatteryStatusViewCell { return cell }
        return BatteryStatusViewCell()
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
private extension BatteryStatusViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BatteryStatusViewCell {
    
}

// MARK: - Action
@objc private extension BatteryStatusViewCell {
    
}

// MARK: - Private
private extension BatteryStatusViewCell {
    
}
