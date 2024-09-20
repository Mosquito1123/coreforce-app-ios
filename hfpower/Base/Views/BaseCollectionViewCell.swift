//
//  BaseCollectionViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/9/20.
//

import UIKit

class BaseCollectionViewCell<ItemType>: UICollectionViewCell {
    
    // MARK: - Accessor
    var element: ItemType? {
        didSet {
            configure()
        }
    }
    
    // 配置 Cell 的方法，需要子类实现
    func configure() {
    }
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BaseCollectionViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BaseCollectionViewCell { return cell }
        return BaseCollectionViewCell()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupSubviews()
        setupLayout()
    }

}

// MARK: - Setup
private extension BaseCollectionViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BaseCollectionViewCell {
    
}

// MARK: - Action
@objc private extension BaseCollectionViewCell {
    
}

// MARK: - Private
private extension BaseCollectionViewCell {
    
}
