//
//  CabinetFilterHeaderReusableView.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetFilterHeaderReusableView: UICollectionReusableView {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x262626FF)
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func viewIdentifier() -> String {
        return String(describing: self)
    }
    
    class func view(with collectionView: UICollectionView, ofKind kind: String, for indexPath: IndexPath) -> CabinetFilterHeaderReusableView {
        let identifier = viewIdentifier()
        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? CabinetFilterHeaderReusableView { return view }
        return CabinetFilterHeaderReusableView()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

}

// MARK: - Setup
private extension CabinetFilterHeaderReusableView {
    
    private func setupSubviews() {
        self.addSubview(self.titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),

        ])
    }
    
}

// MARK: - Public
extension CabinetFilterHeaderReusableView {
    
}

// MARK: - Action
@objc private extension CabinetFilterHeaderReusableView {
    
}

// MARK: - Private
private extension CabinetFilterHeaderReusableView {
    
}
