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
        label.textColor = UIColor(named: "333333")
        label.font = UIFont.systemFont(ofSize: 12,weight: .medium)
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
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalElementIconView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
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
