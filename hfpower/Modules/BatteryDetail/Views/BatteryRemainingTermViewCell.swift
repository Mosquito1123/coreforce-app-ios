//
//  BatteryRemainingTermViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatteryRemainingTermViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
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
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup
private extension BatteryRemainingTermViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
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
