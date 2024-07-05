//
//  CabinetNumberView.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit

class CabinetNumberView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "电池柜编号"
        label.textColor = UIColor(rgba:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "TQC03177"
        label.textColor = UIColor(rgba:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
private extension CabinetNumberView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        addSubview(self.titleLabel)
        addSubview(self.numberLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 11),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -11),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.numberLabel.leadingAnchor, constant: -14),
            self.numberLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

        ])
    }
    
}

// MARK: - Public
extension CabinetNumberView {
    
}

// MARK: - Action
@objc private extension CabinetNumberView {
    
}

// MARK: - Private
private extension CabinetNumberView {
    
}
