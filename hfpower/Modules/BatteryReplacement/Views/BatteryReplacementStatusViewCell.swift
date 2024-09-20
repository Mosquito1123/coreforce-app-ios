//
//  BatteryReplacementStatusViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/15.
//

import UIKit

class BatteryReplacementStatusViewCell: BaseTableViewCell<BatteryReplacementStatus> {
    
    // MARK: - Accessor
    override func configure() {
        if let item = element {
            self.titleLabel.text = item.title
            self.contentLabel.text = item.content
            if item.type == 0{
                self.statusButton.setTitle("\(item.id ?? 0)", for: .normal)
                self.statusButton.setTitleColor(.white, for: .normal)
                self.statusButton.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
                self.contentLabel.textColor = UIColor(hex:0xEA4E42FF)
                self.titleLabel.textColor = UIColor(hex:0x333333FF)
                self.topLineView.backgroundColor = UIColor(hex:0xE5E6EBFF)
                self.bottomLineView.backgroundColor = UIColor(hex:0xE5E6EBFF)

            }else if item.type == 1{
                self.statusButton.setTitle("\(item.id ?? 0)", for: .normal)
                self.statusButton.setTitleColor(.white, for: .normal)
                self.statusButton.setBackgroundImage(UIColor(hex:0xE5E6EBFF).toImage(), for: .normal)
                self.contentLabel.textColor = UIColor(hex:0x86909CFF)
                self.titleLabel.textColor = UIColor(hex:0x86909CFF)
                self.topLineView.backgroundColor = UIColor(hex:0xE5E6EBFF)
                self.bottomLineView.backgroundColor = UIColor(hex:0xE5E6EBFF)
            }else if item.type == 2{
                self.statusButton.setTitle("", for: .normal)
                self.statusButton.setTitleColor(.white, for: .normal)
                self.statusButton.setBackgroundImage(UIImage(named: "selected"), for: .normal)
                self.contentLabel.textColor = UIColor(hex:0x666666FF)
                self.titleLabel.textColor = UIColor(hex:0x333333FF)
                self.topLineView.backgroundColor = UIColor(hex:0x447AFEFF)
                self.bottomLineView.backgroundColor = UIColor(hex:0x447AFEFF)
            }
        }
    }
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex:0xE5E6EBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex:0xE5E6EBFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "取走电池"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "如未正常弹开仓门，请点击【卡仓取电】扫码"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex:0x666666FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("1", for: .normal)
        button.setTitle("1", for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Subviews
    
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> BatteryReplacementStatusViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BatteryReplacementStatusViewCell { return cell }
        return BatteryReplacementStatusViewCell(style: .default, reuseIdentifier: identifier)
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

}

// MARK: - Setup
private extension BatteryReplacementStatusViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.addSubview(statusButton)
        self.contentView.addSubview(self.topLineView)
        self.contentView.addSubview(self.bottomLineView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.contentLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.statusButton.widthAnchor.constraint(equalToConstant: 20),
            self.statusButton.heightAnchor.constraint(equalToConstant: 20),
            self.statusButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.statusButton.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 24),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.statusButton.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -22),
            self.topLineView.widthAnchor.constraint(equalToConstant: 2),
            self.topLineView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.topLineView.centerXAnchor.constraint(equalTo: self.statusButton.centerXAnchor),
            self.topLineView.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -3),
            self.bottomLineView.widthAnchor.constraint(equalToConstant: 2),
            self.bottomLineView.topAnchor.constraint(equalTo: self.statusButton.bottomAnchor,constant: 3),
            self.bottomLineView.centerXAnchor.constraint(equalTo: self.statusButton.centerXAnchor),
            self.bottomLineView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 8),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            
        ])
    }
    
}

// MARK: - Public
extension BatteryReplacementStatusViewCell {
    
}

// MARK: - Action
@objc private extension BatteryReplacementStatusViewCell {
    
}

// MARK: - Private
private extension BatteryReplacementStatusViewCell {
    
}
