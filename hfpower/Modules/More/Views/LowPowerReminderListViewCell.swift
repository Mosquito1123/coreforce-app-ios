//
//  LowPowerReminderListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LowPowerReminderListViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var switchAction:((UISwitch)->Void)?
    var element:LowPowerReminder?{
        didSet{
            self.titleLabel.text = element?.title
            self.contentLabel.text = element?.content
            self.switchButton.isOn = element?.selected == true
            
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x222222FF)
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(rgba:0xA0A0A0FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var switchButton:UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = UIColor(rgba: 0x447AFEFF)
        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

        switchButton.translatesAutoresizingMaskIntoConstraints = false
        return switchButton
    }()
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> LowPowerReminderListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LowPowerReminderListViewCell { return cell }
        return LowPowerReminderListViewCell(style: .default, reuseIdentifier: identifier)
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
    override func layoutSubviews() {
        super.layoutSubviews()
        switchButton.backgroundColor = UIColor(rgba:0xCED4E0FF)
        switchButton.layer.cornerRadius = switchButton.frame.height / 2.0
        switchButton.layer.masksToBounds = true
    }
}

// MARK: - Setup
private extension LowPowerReminderListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
        self.containerView.addSubview(self.switchButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor,constant: -6),
            contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -14.5),
            contentLabel.trailingAnchor.constraint(lessThanOrEqualTo: switchButton.leadingAnchor,constant: -14),
            switchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -14),
            switchButton.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 14),


        ])
    }
    
}

// MARK: - Public
extension LowPowerReminderListViewCell {
    
}

// MARK: - Action
@objc private extension LowPowerReminderListViewCell {
    // 目标方法
        @objc func switchValueChanged(_ sender: UISwitch) {
            self.switchAction?(sender)
        }
}

// MARK: - Private
private extension LowPowerReminderListViewCell {
    
}
