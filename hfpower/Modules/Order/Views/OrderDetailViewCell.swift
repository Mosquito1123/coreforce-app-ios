//
//  OrderDetailViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/19.
//

import UIKit
enum OrderDetailViewCellCornerType{
    case first
    case last
    case all
    case none
}
class OrderDetailViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var cornerType:DepositManagementCellCornerType = .none{
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
    var element:OrderDetailItem?{
        didSet{
            self.titleLabel.text = element?.title
            self.contentLabel.text = element?.content
            self.extraLabel.text = element?.extra
            
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
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(rgba: 0x666666FF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(rgba: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgba: 0xFF3A3AFF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> OrderDetailViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrderDetailViewCell { return cell }
        return OrderDetailViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

}

// MARK: - Setup
private extension OrderDetailViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(extraLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0.5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -0.5),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            // Content label constraints
            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
             
            extraLabel.trailingAnchor.constraint(equalTo: contentLabel.leadingAnchor, constant: -10),
            extraLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
        ])
    }
    
}

// MARK: - Public
extension OrderDetailViewCell {
    
}

// MARK: - Action
@objc private extension OrderDetailViewCell {
    
}

// MARK: - Private
private extension OrderDetailViewCell {
    
}
class OrderDetailHeaderView:UITableViewHeaderFooterView{
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
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        
    }
    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            self.contentView.heightAnchor.constraint(equalToConstant: 16)
//        ])
        
    }
}
