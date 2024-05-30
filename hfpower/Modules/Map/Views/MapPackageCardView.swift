//
//  MapPackageCardView.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
typealias GoToBuyPackageCardAction = (_ sender:UIButton)->Void
class MapPackageCardView: UIView {

    // MARK: - Accessor
    var goToBuyPackageCardAction:GoToBuyPackageCardAction?
    // MARK: - Subviews
    lazy var packageCardButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "package_card_button"), for: .normal)
        button.setImage(UIImage(named: "package_card_button"), for: .highlighted)

        button.addTarget(self, action: #selector(packageCardButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
private extension MapPackageCardView {
    
    private func setupSubviews() {
        addSubview(packageCardButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            self.packageCardButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.packageCardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.packageCardButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.packageCardButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}

// MARK: - Public
extension MapPackageCardView {
    
}

// MARK: - Action
@objc private extension MapPackageCardView {
    @objc func packageCardButtonAction(_ sender:UIButton){
        self.goToBuyPackageCardAction?(sender)
    }
}

// MARK: - Private
private extension MapPackageCardView {
    
}
