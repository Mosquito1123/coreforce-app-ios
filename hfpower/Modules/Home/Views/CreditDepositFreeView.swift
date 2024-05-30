//
//  CreditDepositFreeView.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
typealias ButtonActionBlock = (_ sender:UIButton)->Void
class CreditDepositFreeView: UIView {

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
        let attrString = NSMutableAttributedString(string: "您的信用免押即将到期，请为了您的正常使用请尽快进行信用免押认证。 ")
     
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("前往认证", for: .normal)
        button.setTitleColor(
            UIColor(named: "416CFF"), for: .normal)
        button.setImage(UIImage(named: "common_icon_arrow_more"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        button.addTarget(self, action: #selector(goToAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
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
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.setImagePosition(type: .imageRight, Space: 5)
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true
    }

}

// MARK: - Setup
private extension CreditDepositFreeView {
    
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
extension CreditDepositFreeView {
    
}

// MARK: - Action
@objc private extension CreditDepositFreeView {
    @objc func goToAction(_ sender:UIButton){
        self.actionBlock?(sender)
    }
}

// MARK: - Private
private extension CreditDepositFreeView {
    
}
