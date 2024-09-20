//
//  ContactInfoViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/20.
//

import UIKit

class ContactInfoViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "客服电话："
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("400-6789-509", for: .normal)
        button.setTitle("400-6789-509", for: .highlighted)

        button.setTitleColor(UIColor(hex:0x447AFEFF), for: .normal)
        button.setTitleColor(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5), for: .highlighted)
       
        button.addAction(for: .touchUpInside) {
            if let phoneURL = URL(string: "tel://400-6789-509"), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> ContactInfoViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ContactInfoViewCell { return cell }
        return ContactInfoViewCell()
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
private extension ContactInfoViewCell {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.contentView.addSubview(self.contactLabel)
        self.contentView.addSubview(self.phoneNumberButton)
        phoneNumberButton.sizeToFit()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            contactLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 32),
            contactLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor,constant: -36),
            contactLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -32),
            phoneNumberButton.centerYAnchor.constraint(equalTo: self.contactLabel.centerYAnchor),
            phoneNumberButton.leadingAnchor.constraint(equalTo: contactLabel.trailingAnchor,constant: 5.5),
            
            
        
        ])
    }
    
}

// MARK: - Public
extension ContactInfoViewCell {
    
}

// MARK: - Action
@objc private extension ContactInfoViewCell {
    
}

// MARK: - Private
private extension ContactInfoViewCell {
    
}
