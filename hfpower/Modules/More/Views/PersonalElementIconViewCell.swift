//
//  PersonalElementIconViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/26.
//

import UIKit

class PersonalElementIconViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var elementIconView: PersonalElementIconView = {
        let view = PersonalElementIconView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> PersonalElementIconViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? PersonalElementIconViewCell { return cell }
        return PersonalElementIconViewCell()
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
private extension PersonalElementIconViewCell {
    
    private func setupSubviews() {
        self.contentView.addSubview(elementIconView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            elementIconView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            elementIconView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            elementIconView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            elementIconView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

        ])
        
    }
    
}

// MARK: - Public
extension PersonalElementIconViewCell {
    
}

// MARK: - Action
@objc private extension PersonalElementIconViewCell {
    
}

// MARK: - Private
private extension PersonalElementIconViewCell {
    
}
