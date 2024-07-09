//
//  LogoffTableHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogoffTableHeaderView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
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
private extension LogoffTableHeaderView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension LogoffTableHeaderView {
    
}

// MARK: - Action
@objc private extension LogoffTableHeaderView {
    
}

// MARK: - Private
private extension LogoffTableHeaderView {
    
}
