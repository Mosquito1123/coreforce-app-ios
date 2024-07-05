//
//  CabinetDetailBottomView.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit

class CabinetDetailBottomView: UIView {

    // MARK: - Accessor
    var scanAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var scanButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("扫码换电", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.setImage(UIImage(named: "scan"), for: .highlighted)

        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(scanButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        scanButton.setImagePosition(type: .imageLeft, Space: 6)
       
    }
}

// MARK: - Setup
private extension CabinetDetailBottomView {
    
    private func setupSubviews() {
        addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            scanButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            scanButton.heightAnchor.constraint(equalToConstant: 49),


        ])
    }
    
}

// MARK: - Public
extension CabinetDetailBottomView {
    
}

// MARK: - Action
@objc private extension CabinetDetailBottomView {
    @objc func scanButtonAction(_ sender:UIButton){
        self.scanAction?(sender)
    }
}

// MARK: - Private
private extension CabinetDetailBottomView {
    
}
