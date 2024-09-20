//
//  AboutListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class AboutListViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var element:About?{
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
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x666666FF)
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hex:0x333333FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> AboutListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AboutListViewCell { return cell }
        return AboutListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension AboutListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.contentLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 17),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -17),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentLabel.leadingAnchor,constant: -14),
            contentLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -14),
            


        ])
    }
    
}

// MARK: - Public
extension AboutListViewCell {
    
}

// MARK: - Action
@objc private extension AboutListViewCell {
    
}

// MARK: - Private
private extension AboutListViewCell {
    
}
