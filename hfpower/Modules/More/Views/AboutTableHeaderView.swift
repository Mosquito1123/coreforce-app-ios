//
//  AboutTableHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class AboutTableHeaderView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hflogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var markImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hfmark")
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
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension AboutTableHeaderView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        self.addSubview(logoImageView)
        self.addSubview(markImageView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 90),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            logoImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 30),
            logoImageView.bottomAnchor.constraint(equalTo: markImageView.topAnchor,constant: -16),

            markImageView.widthAnchor.constraint(equalToConstant: 120),
            markImageView.heightAnchor.constraint(equalToConstant: 34.5),
            markImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])
        
    }
    
}

// MARK: - Public
extension AboutTableHeaderView {
    
}

// MARK: - Action
@objc private extension AboutTableHeaderView {
    
}

// MARK: - Private
private extension AboutTableHeaderView {
    
}
