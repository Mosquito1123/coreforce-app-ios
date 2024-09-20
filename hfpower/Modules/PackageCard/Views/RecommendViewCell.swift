//
//  RecommendViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/1.
//

import UIKit

class RecommendViewCell: BaseTableViewCell<BuyPackageCard>,UITextFieldDelegate {
    
    // MARK: - Accessor
    override func configure() {
        self.titleLabel.text = element?.title
        self.textField.attributedPlaceholder = NSAttributedString(
            string: element?.subtitle ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor(hex:0xA0A0A0FF)
            ]
        )
    }
    
    private var scanButtonHeight: NSLayoutConstraint!
    private var scanButtonWidth: NSLayoutConstraint!
    var scanAction: ButtonActionBlock?
    
    var content: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var enable: Bool = true {
        didSet {
            self.isUserInteractionEnabled = enable
            titleLabel.isUserInteractionEnabled = enable
            titleLabel.font = enable ? UIFont.systemFont(ofSize: 17, weight: .regular) : UIFont.systemFont(ofSize: 17, weight: .medium)
            titleLabel.textColor = enable ? UIColor(hex:0x8C8C8CFF) : UIColor(hex:0xD2D2D2FF)
            textField.attributedPlaceholder = NSAttributedString(
                string: enable ? "点击输入推荐码，选填" : "与套餐卡无法同享",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16, weight: .medium),
                    .foregroundColor: UIColor(hex:0xD2D2D2FF)
                ]
            )
            textField.isEnabled = enable
            scanButton.isHidden = !enable
            scanButtonWidth.constant = enable ? 40 : 0
            scanButtonHeight.constant = enable ? 40 : 0
            layoutIfNeeded()
        }
    }
    
    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "推荐码（选填）"
        label.textColor = UIColor(hex:0x8C8C8CFF)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.textColor = UIColor(hex:0x4D4D4DFF)
        textField.delegate = self
        textField.textAlignment = .right
        textField.attributedPlaceholder = NSAttributedString(
            string: "点击输入或扫描二维码",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor(hex:0xA0A0A0FF)
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "input_scan")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(hex:0x555555FF)
        button.addTarget(self, action: #selector(scanButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> RecommendViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecommendViewCell { return cell }
        return RecommendViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Implement any additional actions after text field editing ends
    }
    
    func clearText() {
        textField.text = nil
    }
}

// MARK: - Setup
private extension RecommendViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(textField)
        containerView.addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -6),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: textField.leadingAnchor),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 115)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            textField.trailingAnchor.constraint(equalTo: scanButton.leadingAnchor,constant: -5)
        ])
        
        scanButtonHeight = scanButton.heightAnchor.constraint(equalToConstant: 20)
        scanButtonWidth = scanButton.widthAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            scanButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            scanButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            scanButtonHeight,
            scanButtonWidth
        ])
    }
    
}

// MARK: - Public
extension RecommendViewCell {
    
}

// MARK: - Action
@objc private extension RecommendViewCell {
    
    
    // MARK: - Actions
    
    @objc private func scanButtonTapped(_ sender: UIButton) {
        scanAction?(sender)
    }
}

// MARK: - Private
private extension RecommendViewCell {
    
}
