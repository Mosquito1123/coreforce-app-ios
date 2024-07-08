//
//  PersonalViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit
enum PersonalViewCellType:Int{
    case choose
    case `switch`
    case chooseContent
    case button
}
enum PersonalViewCellCornerType{
    case first
    case last
    case all
    case none
}
class PersonalViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var element:SettingsItem = SettingsItem(){
        didSet{
            if let cellType = PersonalViewCellType(rawValue: element.type){
                switch cellType {
                case .choose:
                    self.titleLabel.isHidden = false
                    self.iconImageView.isHidden = false
                    self.logoutLabel.isHidden = true
                    self.contentLabel.isHidden = true
                    self.switchButton.isHidden = true
                    self.switchContentLabel.isHidden = true
                    self.titleLabel.text = element.title
                case .switch:
                    self.titleLabel.isHidden = false
                    self.iconImageView.isHidden = true
                    self.logoutLabel.isHidden = true
                    self.contentLabel.isHidden = true
                    self.switchButton.isHidden = false
                    self.switchContentLabel.isHidden = false
                    self.titleLabel.text = element.title
                    self.switchContentLabel.text = element.content
                    self.switchButton.isOn = element.selected

                case .chooseContent:
                    self.titleLabel.isHidden = false
                    self.iconImageView.isHidden = false
                    self.logoutLabel.isHidden = true
                    self.contentLabel.isHidden = false
                    self.switchButton.isHidden = true
                    self.switchContentLabel.isHidden = true
                    self.titleLabel.text = element.title
                    self.contentLabel.text = element.content
                case .button:
                    self.titleLabel.isHidden = true
                    self.iconImageView.isHidden = true
                    self.logoutLabel.isHidden = false
                    self.contentLabel.isHidden = true
                    self.switchButton.isHidden = true
                    self.switchContentLabel.isHidden = true
                    self.logoutLabel.text = element.title
                }
            }
            
        }
    }
   
    var cornerType:PersonalViewCellCornerType = .none{
        didSet{
            switch cornerType {
            case .first:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .last:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .all:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .none:
                self.containerView.layer.cornerRadius = 0
                
            }
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var switchButton:UISwitch = {
        let switchButton = UISwitch()
        switchButton.isHidden = true
        switchButton.onTintColor = UIColor(rgba: 0x447AFEFF)
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        return switchButton
    }()
    lazy var switchContentLabel:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "关闭后将不再推送所有APP通知"
        label.textColor = UIColor(rgba: 0xA0A0A0FF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "退出登录"
        label.textColor = UIColor(rgba: 0xF53F3FFF)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgba: 0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "135****1234"
        label.textColor = UIColor(rgba: 0xA0A0A0FF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_arrow_right_gray")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> PersonalViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalViewCell { return cell }
        return PersonalViewCell(style: .default, reuseIdentifier: identifier)
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
private extension PersonalViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(logoutLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(contentLabel)
        containerView.addSubview(switchButton)
        containerView.addSubview(switchContentLabel)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            
            // Icon image view constraints
            iconImageView.widthAnchor.constraint(equalToConstant: 18),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            // Content label view constraints
            contentLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor,constant: -6),

            //Logout label view constraints
            logoutLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            logoutLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoutLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),

            //Switch
            switchButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            switchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -14),
            
            //Switch content label
            switchContentLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            switchContentLabel.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor,constant: -6),

        ])
    }
    
}

// MARK: - Public
extension PersonalViewCell {
    
}

// MARK: - Action
@objc private extension PersonalViewCell {
    
}

// MARK: - Private
private extension PersonalViewCell {
    
}
class SettingsHeaderView:UITableViewHeaderFooterView{
    class func viewIdentifier() -> String {
        return String(describing: self)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupSubviews() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
    }
}
