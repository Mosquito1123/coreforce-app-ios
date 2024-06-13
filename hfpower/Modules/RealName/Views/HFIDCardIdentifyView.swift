//
//  HFIDCardIdentifyView.swift
//  hfpower
//
//  Created by EDY on 2024/6/13.
//

import UIKit

import UIKit

class HFIDCardIdentifyView: UIView {
    
    // MARK: - Properties
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "身份证信息自动识别"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "id_card")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "scan_id_card"), for: .normal)
        button.addTarget(self, action: #selector(scanButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonActionBlock: ((UIButton) -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        setupSubviews()
        setupLayout()
    }
    
    
    
    
    
    // MARK: - Actions
    
    @objc private func scanButtonTapped(_ button: UIButton) {
        buttonActionBlock?(button)
    }
}


// MARK: - Setup
private extension HFIDCardIdentifyView {
    // MARK: - Setup
    
    private func setupSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(scanButton)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            iconView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -14),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: scanButton.leadingAnchor, constant: -14),
            
            scanButton.widthAnchor.constraint(equalToConstant: 30),
            scanButton.heightAnchor.constraint(equalToConstant: 30),
            scanButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            scanButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
        ])
    }
    
}

// MARK: - Public
extension HFIDCardIdentifyView {
    
}

// MARK: - Action
@objc private extension HFIDCardIdentifyView {
    
}

// MARK: - Private
private extension HFIDCardIdentifyView {
    
}
