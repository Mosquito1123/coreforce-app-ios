//
//  CityHistoryViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/10/12.
//

import UIKit

class CityHistoryViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var relocate:ButtonActionBlock?
    var element:CityHistoryItem?{
        didSet{
            self.titleLabel.text = element?.title
            self.iconImageView.isHidden = element?.isCurrent == false
            self.actionButton.isHidden = element?.isCurrent == false

        }
    }
    // MARK: - Subviews
    // 使用懒加载创建图标
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "search_list_icon_location")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 使用懒加载创建文字标签
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.numberOfLines = 1
        label.textColor = UIColor(hex:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 使用懒加载创建按钮
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("重新定位", for: .normal)
        button.setImage(UIImage(named: "device_refresh"), for: .normal)
        button.setTitleColor(UIColor(hex:0x447AFEFF), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> CityHistoryViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CityHistoryViewCell { return cell }
        return CityHistoryViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        actionButton.setImagePosition(type: .imageLeft, Space: 3)
    }

}

// MARK: - Setup
private extension CityHistoryViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        // 添加子视图
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
    }
    
    private func setupLayout() {
        // 设置自动布局约束
        NSLayoutConstraint.activate([
            // 图标约束
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            // 文字标签约束
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 2),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14.5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -17),
            
            // 按钮约束
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // 确保标签和按钮之间的距离
            
        ])
    }
    
}

// MARK: - Public
extension CityHistoryViewCell {
    
}

// MARK: - Action
@objc private extension CityHistoryViewCell {
    @objc func actionButtonTapped(_ sender:UIButton){
        self.relocate?(sender)
    }
}

// MARK: - Private
private extension CityHistoryViewCell {
    
}
class CityHistoryViewHeaderView:UITableViewHeaderFooterView{
    var element:CityHistory?{
        didSet{
            self.titleLabel.text = element?.title
        }
    }
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex: 0x666666FF)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func viewIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> CityHistoryViewHeaderView {
        let identifier = viewIdentifier()
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? CityHistoryViewHeaderView {return view}
        return CityHistoryViewHeaderView(reuseIdentifier: identifier)
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupLayout()
    }
}
private extension CityHistoryViewHeaderView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex: 0xF7F7F7FF)
        self.contentView.backgroundColor = UIColor(hex: 0xF7F7F7FF)
        self.contentView.addSubview(self.titleLabel)
    }
    
    private func setupLayout() {
        // 使用AutoLayout设置label位置
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
