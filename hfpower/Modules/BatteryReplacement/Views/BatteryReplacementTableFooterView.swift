//
//  BatteryReplacementTableFooterView.swift
//  hfpower
//
//  Created by EDY on 2024/7/15.
//

import UIKit

class BatteryReplacementTableFooterView: UIView {

    // MARK: - Accessor
    var fetchCellBlock:ButtonActionBlock?
    // MARK: - Subviews
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.tintAdjustmentMode = .automatic
        button.setTitle("卡仓取电", for: .normal)
        button.setTitle("卡仓取电", for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        button.setBackgroundImage(UIColor(hex:0x8178F0FF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x8178F0FF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "fetch_cell"), for: .normal)
        button.setImage(UIImage(named: "fetch_cell"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.addTarget(self, action: #selector(fetchErrorBattery(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    lazy var groupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "温馨提示"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = "若中途碰到任何无法解决的问题，请拨打客服"
        label.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setTitle("400-6789-509", for: .normal)
        button.setTitle("400-6789-509", for: .highlighted)
        button.setImage(UIImage(named: "customer_service_phone"), for: .normal)
        button.setImage(UIImage(named: "customer_service_phone"), for: .highlighted)

        button.setTitleColor(UIColor(red: 68/255, green: 122/255, blue: 254/255, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(red: 68/255, green: 122/255, blue: 254/255, alpha: 1.0), for: .highlighted)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(phoneNumberTapped(_:)), for: .touchUpInside)
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
    override func layoutSubviews() {
        super.layoutSubviews()
        submitButton.setImagePosition(type: .imageLeft, Space: 6)
        phoneNumberButton.setImagePosition(type: .imageLeft, Space: 2)
    }
}

// MARK: - Setup
private extension BatteryReplacementTableFooterView {
    
    private func setupSubviews() {
        backgroundColor = .white
        addSubview(submitButton)
        addSubview(groupView)
        
        groupView.addSubview(tipLabel)
        groupView.addSubview(contactLabel)
        groupView.addSubview(phoneNumberButton)
        
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalToConstant: 165),
            submitButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Group View Constraints
            groupView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 30),
            groupView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            groupView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40),
            
            // Tip Label Constraints
            tipLabel.leadingAnchor.constraint(equalTo: groupView.leadingAnchor, constant: 16),
            tipLabel.topAnchor.constraint(equalTo: groupView.topAnchor, constant: 14),
            
            // Contact Label Constraints
            contactLabel.leadingAnchor.constraint(equalTo: groupView.leadingAnchor, constant: 16),
            contactLabel.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 14),
            contactLabel.bottomAnchor.constraint(equalTo: self.phoneNumberButton.topAnchor, constant: -12),
            // Phone Number Button Constraints
            phoneNumberButton.leadingAnchor.constraint(equalTo: groupView.leadingAnchor, constant: 16),
            phoneNumberButton.trailingAnchor.constraint(lessThanOrEqualTo: self.groupView.trailingAnchor,constant: -16),
            phoneNumberButton.bottomAnchor.constraint(equalTo: self.groupView.bottomAnchor, constant: -16)
        ])
    }
    
}

// MARK: - Public
extension BatteryReplacementTableFooterView {
    
}

// MARK: - Action
@objc private extension BatteryReplacementTableFooterView {
    @objc func phoneNumberTapped(_ sender:UIButton){
        if let url = URL(string: "tel://4006789509") {
            UIApplication.shared.open(url)
        }
    }
    @objc func fetchErrorBattery(_ sender:UIButton){
        self.fetchCellBlock?(sender)
    }
}

// MARK: - Private
private extension BatteryReplacementTableFooterView {
    
}
