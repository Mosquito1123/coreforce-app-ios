//
//  PersonalElementIconView.swift
//  hfpower
//
//  Created by EDY on 2024/6/26.
//

import UIKit

class PersonalElementIconView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "- -"
        label.textColor = UIColor(hex:0x666666FF)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        return iconImageView
    }()
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
private extension PersonalElementIconView {
    
    private func setupSubviews() {
        self.addSubview(self.iconImageView)
        self.addSubview(self.titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
                   iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                   iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                   iconImageView.widthAnchor.constraint(equalToConstant: 24),
                   iconImageView.heightAnchor.constraint(equalToConstant: 24),
                   
                   titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                   titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
                   titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                   titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                   titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
               ])
    }
    
}

// MARK: - Public
extension PersonalElementIconView {
    
}

// MARK: - Action
@objc private extension PersonalElementIconView {
    
}

// MARK: - Private
private extension PersonalElementIconView {
    
}
