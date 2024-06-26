//
//  PersonalElementView.swift
//  hfpower
//
//  Created by EDY on 2024/6/26.
//

import UIKit

class PersonalElementView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "- -"
        label.textColor = UIColor(named: "333333")
        label.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "- -"
        label.textColor = UIColor(named: "666666")
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
private extension PersonalElementView {
    
    private func setupSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor,constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -14),

        ])
    }
    
}

// MARK: - Public
extension PersonalElementView {
    
}

// MARK: - Action
@objc private extension PersonalElementView {
    
}

// MARK: - Private
private extension PersonalElementView {
    
}
