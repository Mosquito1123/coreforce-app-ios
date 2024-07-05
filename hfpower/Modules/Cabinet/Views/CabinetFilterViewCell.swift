//
//  CabinetFilterViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetFilterViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    var model:CabinetFilter?{
        didSet{
            
        }
    }
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> CabinetFilterViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CabinetFilterViewCell { return cell }
        return CabinetFilterViewCell()
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
private extension CabinetFilterViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension CabinetFilterViewCell {
    
}

// MARK: - Action
@objc private extension CabinetFilterViewCell {
    
}

// MARK: - Private
private extension CabinetFilterViewCell {
    
}
