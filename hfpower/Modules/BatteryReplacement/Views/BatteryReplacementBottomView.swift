//
//  BatteryReplacementBottomView.swift
//  hfpower
//
//  Created by EDY on 2024/7/15.
//

import UIKit

class BatteryReplacementBottomView: UIView {

    // MARK: - Accessor
    var sureAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("租电完成，点击返回首页", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)

        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonAction(_:)), for: .touchUpInside)
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
private extension BatteryReplacementBottomView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        addSubview(sureButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            sureButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            sureButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            sureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            sureButton.heightAnchor.constraint(equalToConstant: 49),


        ])
    }
    
}

// MARK: - Public
extension BatteryReplacementBottomView {
    
}

// MARK: - Action
@objc private extension BatteryReplacementBottomView {
    @objc func sureButtonAction(_ sender:UIButton){
        self.sureAction?(sender)
    }
}

// MARK: - Private
private extension BatteryReplacementBottomView {
    
}
