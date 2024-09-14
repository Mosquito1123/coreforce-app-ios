//
//  MessageListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

import UIKit

class MessageListViewCell: BaseTableViewCell<HFMessageData> {
    
    // MARK: - Accessor
    override func configure() {
        guard let message = element else {return}
        updateUI(with: message)
    }
    private func updateUI(with messageData: HFMessageData) {
        
        
        detailLabel.text = messageData.msg
        
        // Convert string to NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let timeDate = dateFormatter.date(from: messageData.createAt) else { return }
        
        // Calculate time difference
        // Calculate time difference
        let timeInterval = timeDate.timeIntervalSinceNow
        var temp: Int
        
        if timeInterval < 60 {
            timeLabel.text = "刚刚"
        } else if timeInterval / 60 < 60 {
            temp = Int(timeInterval / 60)
            timeLabel.text = "\(temp)分钟前"
        } else if timeInterval / 3600 < 24 {
            temp = Int(timeInterval / 3600)
            timeLabel.text = "\(temp)小时前"
        } else if timeInterval / 3600 < 48 {
            timeLabel.text = "昨天"
        } else if timeInterval / 3600 < 72 {
            timeLabel.text = "前天"
        } else {
            timeLabel.text = messageData.createAt
        }
        
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "标题"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 44/255, green: 88/255, blue: 158/255, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "内容"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> MessageListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageListViewCell { return cell }
        return MessageListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension MessageListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.lineView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.timeLabel)
        self.containerView.addSubview(self.detailLabel)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
        ])
        // Set constraints for titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
        
        // Set constraints for timeLabel
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
        
        // Set constraints for detailLabel
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22.5),
            detailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            detailLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
}

// MARK: - Public
extension MessageListViewCell {
    
}

// MARK: - Action
@objc private extension MessageListViewCell {
    
}

// MARK: - Private
private extension MessageListViewCell {
    
}
