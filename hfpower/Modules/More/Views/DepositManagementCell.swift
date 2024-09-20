//
//  DepositManagementCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class DepositManagementCell: UITableViewCell {
    
    // MARK: - Accessor
    var cornerType:BaseCellCornerType = .none{
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
    var element:DepositManagementItem?{
        didSet{
            self.titleLabel.text = element?.title
            self.contentLabel.text = element?.content
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
        label.textColor = UIColor(hex:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "135****1234"
        label.textColor = UIColor(hex:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> DepositManagementCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DepositManagementCell { return cell }
        return DepositManagementCell(style: .default, reuseIdentifier: identifier)
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
private extension DepositManagementCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
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
        ])
    }
    
}

// MARK: - Public
extension DepositManagementCell {
    
}

// MARK: - Action
@objc private extension DepositManagementCell {
    
}

// MARK: - Private
private extension DepositManagementCell {
    
}
class DepositManagementHeaderView:UITableViewHeaderFooterView{
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
        self.contentView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        
    }
    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            self.contentView.heightAnchor.constraint(equalToConstant: 16)
//        ])
        
    }
}

