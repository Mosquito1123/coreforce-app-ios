//
//  MapInviteView.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
typealias GoToInviteAction = (_ sender:UIButton)->Void

class MapInviteView: UIView {

    // MARK: - Accessor
    var goToInviteAction:GoToInviteAction?

    // MARK: - Subviews
    lazy var inviteButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "invite_activity_button"), for: .normal)
        button.setImage(UIImage(named: "invite_activity_button"), for: .highlighted)
        button.addTarget(self, action: #selector(inviteAction(_:)), for: .touchUpInside)
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
private extension MapInviteView {
    
    private func setupSubviews() {
        addSubview(inviteButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            self.inviteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.inviteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.inviteButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.inviteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
}

// MARK: - Public
extension MapInviteView {
    
}

// MARK: - Action
@objc private extension MapInviteView {
    @objc func inviteAction(_ sender:UIButton){
        self.goToInviteAction?(sender)
    }
}

// MARK: - Private
private extension MapInviteView {
    
}
