//
//  BatterySiteViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import UIKit

class BatterySiteViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BatterySiteViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BatterySiteViewCell { return cell }
        return BatterySiteViewCell()
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
private extension BatterySiteViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BatterySiteViewCell {
    
}

// MARK: - Action
@objc private extension BatterySiteViewCell {
    
}

// MARK: - Private
private extension BatterySiteViewCell {
    
}
