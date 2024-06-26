//
//  PersonalIconView.swift
//  hfpower
//
//  Created by EDY on 2024/6/26.
//

import UIKit

class PersonalIconView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
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
private extension PersonalIconView {
    
    private func setupSubviews() {
        self.addSubview(self.iconImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 29),
            iconImageView.heightAnchor.constraint(equalToConstant: 29),


        ])
    }
    
}

// MARK: - Public
extension PersonalIconView {
    
}

// MARK: - Action
@objc private extension PersonalIconView {
    
}

// MARK: - Private
private extension PersonalIconView {
    
}
