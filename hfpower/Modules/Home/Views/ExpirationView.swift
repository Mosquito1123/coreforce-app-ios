//
//  ExpirationView.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit

class ExpirationView: UIView {

    // MARK: - Accessor
    var actionBlock:ButtonActionBlock?
    var attributedText:NSAttributedString?{
        didSet{
            titleLabel.attributedText = attributedText
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attrString = NSMutableAttributedString(string: "您的电池租期剩余1天17小时，为了您正常使用，请尽快续租。 ")
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        let strSubAttr1: [NSMutableAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2,alpha:1.000000)]
        attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: 8))
        let strSubAttr2: [NSMutableAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(red: 1, green: 0.3, blue: 0.31,alpha:1.000000)]
        attrString.addAttributes(strSubAttr2, range: NSRange(location: 8, length: 6))
        let strSubAttr3: [NSMutableAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2,alpha:1.000000)]
        attrString.addAttributes(strSubAttr3, range: NSRange(location: 14, length: 16))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("立即续租", for: .normal)
        button.setTitleColor(
            UIColor(named: "416CFF"), for: .normal)
        button.setImage(UIImage(named: "common_icon_arrow_more"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        button.addTarget(self, action: #selector(goToAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.setImagePosition(type: .imageRight, Space: 5)
    }
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        // shadowCode
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension ExpirationView {
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor,constant: -20),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            actionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),

        ])
    }
    
}

// MARK: - Public
extension ExpirationView {
    
}

// MARK: - Action
@objc private extension ExpirationView {
    @objc func goToAction(_ sender:UIButton){
        self.actionBlock?(sender)
    }
}

// MARK: - Private
private extension ExpirationView {
    
}
