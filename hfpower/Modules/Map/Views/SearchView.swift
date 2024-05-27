//
//  SearchView.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class SearchView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup
private extension SearchView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension SearchView {
    
}

// MARK: - Action
@objc private extension SearchView {
    
}

// MARK: - Private
private extension SearchView {
    
}
