//
//  PersonalIconView.swift
//  hfpower
//
//  Created by EDY on 2024/6/26.
//

import UIKit

class PersonalIconView: UIView {

    // MARK: - Accessor
    var nextAction:((UITapGestureRecognizer)->Void)?
    var iconWidth:NSLayoutConstraint!
    var iconHeight:NSLayoutConstraint!
    // MARK: - Subviews
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
private extension PersonalIconView {
    
    private func setupSubviews() {
        self.isUserInteractionEnabled = true
        self.addSubview(self.iconImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        iconWidth = iconImageView.widthAnchor.constraint(equalToConstant: 29)
        iconHeight = iconImageView.heightAnchor.constraint(equalToConstant: 29)
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            iconWidth,
            iconHeight,


        ])
    }
    
}

// MARK: - Public
extension PersonalIconView {
    
}

// MARK: - Action
@objc private extension PersonalIconView {
    @objc func tapped(_ sender:UITapGestureRecognizer){
        self.nextAction?(sender)
    }
}

// MARK: - Private
private extension PersonalIconView {
    
}
