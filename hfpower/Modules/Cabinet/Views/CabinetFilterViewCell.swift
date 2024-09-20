//
//  CabinetFilterViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetFilterViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    var model:CabinetFilterItem?{
        didSet{
            self.titleLabel.text = model?.title
            if  model?.selected == true{
                self.backgroundColor = UIColor(hex:0x416CFFFF).withAlphaComponent(0.1)
                self.titleLabel.textColor = UIColor(hex:0x416CFFFF)
                self.titleLabel.font = UIFont.systemFont(ofSize: 13,weight: .semibold)
            }else{
                self.backgroundColor = UIColor(hex:0xF4F4F4FF)
                self.titleLabel.textColor = UIColor(hex:0x262626FF)
                self.titleLabel.font = UIFont.systemFont(ofSize: 13)
            }
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x262626FF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
        super.init(coder:coder)
    }

}

// MARK: - Setup
private extension CabinetFilterViewCell {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0xF4F4F4FF)
        self.layer.cornerRadius = 18
        self.contentView.addSubview(self.titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 9),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -9),

        ])
        
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
