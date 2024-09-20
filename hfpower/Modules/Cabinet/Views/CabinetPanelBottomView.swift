//
//  CabinetPanelBottomView.swift
//  hfpower
//
//  Created by EDY on 2024/9/20.
//

import UIKit

class CabinetPanelBottomView: UIView {

    // MARK: - Accessor
    var navigateAction:ButtonActionBlock?
    var scanAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(hex:0x1D2129FF), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex:0xE5E6EBFF).cgColor
        button.addTarget(self, action: #selector(navigateButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var scanButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("扫码换电", for: .normal)
        button.tintAdjustmentMode = .automatic
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(scanButtonAction(_:)), for: .touchUpInside)
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
        setupSubviews()
        setupLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        navigateButton.setImagePosition(type: .imageLeft, Space: 5)
       
    }

}

// MARK: - Setup
private extension CabinetPanelBottomView {
    
    private func setupSubviews() {
        backgroundColor = .white
        addSubview(navigateButton)
        addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            scanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            scanButton.heightAnchor.constraint(equalToConstant: 49),
            navigateButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            navigateButton.trailingAnchor.constraint(equalTo: scanButton.leadingAnchor, constant: -13),
            navigateButton.widthAnchor.constraint(equalTo: scanButton.widthAnchor),
            navigateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            navigateButton.heightAnchor.constraint(equalToConstant: 49),
        ])
    }
    
}

// MARK: - Public
extension CabinetPanelBottomView {
    
}

// MARK: - Action
@objc private extension CabinetPanelBottomView {
    @objc func navigateButtonAction(_ sender:UIButton){
        self.navigateAction?(sender)
    }
    @objc func scanButtonAction(_ sender:UIButton){
        self.scanAction?(sender)
    }
}

// MARK: - Private
private extension CabinetPanelBottomView {
    
}
