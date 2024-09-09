//
//  HomeHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

import UIKit

class HomeHeaderView: UIView {
    
    // MARK: - Accessor
    lazy var locationChooseView: LocationChooseView = {
        let view = LocationChooseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var searchView: SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension HomeHeaderView {
    
    private func setupSubviews() {
        backgroundColor = .clear
        addSubview(searchView)
        addSubview(locationChooseView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            locationChooseView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationChooseView.topAnchor.constraint(equalTo: topAnchor),
            locationChooseView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchView.leadingAnchor.constraint(equalTo: locationChooseView.trailingAnchor, constant: 12),
            searchView.topAnchor.constraint(equalTo: topAnchor),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
}

// MARK: - Public
extension HomeHeaderView {
    
}

// MARK: - Action
@objc private extension HomeHeaderView {
    
}

// MARK: - Private
private extension HomeHeaderView {
    
}
