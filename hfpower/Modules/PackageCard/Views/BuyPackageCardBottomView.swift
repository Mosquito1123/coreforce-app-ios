//
//  BuyPackageCardBottomView.swift
//  hfpower
//
//  Created by EDY on 2024/7/4.
//

import UIKit

class BuyPackageCardBottomView: UIView {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    var model: PackageCard? {
        didSet {
            guard let model = model else { return }
            let nf = NumberFormatter()
            nf.maximumFractionDigits = 2
            nf.minimumFractionDigits = 0
            self.totalLabel.text = nf.string(from: model.price ?? NSNumber(value: 0))
            self.submitButton.isEnabled = model.price != nil && self.statusButton.isSelected
        }
    }
    
    var submittedAction: ButtonActionBlock?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "待支付"
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 255/255, green: 58/255, blue: 58/255, alpha: 1)
        label.text = "￥"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor(red: 255/255, green: 58/255, blue: 58/255, alpha: 1)
        label.text = "0"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var privacyView: UITextView = {
        let textView = UITextView()
        let attributedString = NSMutableAttributedString(string: "我已认真阅读并同意《核蜂动力服务协议》", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        ])
        attributedString.addAttributes([
            .link: URL(string: "http://www.coreforce.cn/privacy/member.html")!,
            .foregroundColor: UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 1)
        ], range: NSRange(location: 9, length: 10))
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.isSelectable = true
        textView.dataDetectorTypes = .link
        textView.contentInset = .zero
        textView.backgroundColor = .white
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("确认支付", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 1).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 1).toImage(), for: .selected)
        button.setBackgroundImage(UIColor(red: 49/255, green: 113/255, blue: 239/255, alpha: 0.5).toImage(), for: .disabled)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(onSubmitted(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "unselected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        button.isSelected = true
        button.addTarget(self, action: #selector(statusChanged(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
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
private extension BuyPackageCardBottomView {
    
    private func setupSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 20.0
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(titleLabel)
        addSubview(unitLabel)
        addSubview(totalLabel)
        addSubview(privacyView)
        addSubview(statusButton)
        addSubview(submitButton)
        submitButton.isEnabled = model?.price != nil && self.statusButton.isSelected
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            
            unitLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 2),
            unitLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            totalLabel.leadingAnchor.constraint(equalTo: unitLabel.trailingAnchor),
            totalLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            statusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            statusButton.widthAnchor.constraint(equalToConstant: 16),
            statusButton.heightAnchor.constraint(equalToConstant: 16),
            
            privacyView.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor),
            privacyView.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor),
            privacyView.bottomAnchor.constraint(equalTo: statusButton.bottomAnchor),
            privacyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            submitButton.bottomAnchor.constraint(equalTo: statusButton.bottomAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.widthAnchor.constraint(equalToConstant: 105)
        ])
    }
    
}

// MARK: - Public
extension BuyPackageCardBottomView {
    
}

// MARK: - Action
@objc private extension BuyPackageCardBottomView {
    @objc private func statusChanged(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if let model = self.model {
            self.submitButton.isEnabled = model.price != nil && button.isSelected
        }
    }
    
    @objc private func onSubmitted(_ button: UIButton) {
        if let action = submittedAction {
            action(button)
        }
    }
}

// MARK: - Private
private extension BuyPackageCardBottomView {
    
}
