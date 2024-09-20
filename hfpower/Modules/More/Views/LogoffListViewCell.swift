//
//  LogoffListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogoffListViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var element:Logoff?{
        didSet{
            self.pointLabel.text = element?.title
        }
    }
    // MARK: - Subviews
    lazy var pointView:UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(hex:0xD2D2D2FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pointLabel:UILabel  = {
        let label = UILabel()
        label.text = "自取出电池后，不支持退租金；"
        label.textColor = UIColor(hex:0x333333FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> LogoffListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LogoffListViewCell { return cell }
        return LogoffListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension LogoffListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.pointView)
        self.contentView.addSubview(self.pointLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            pointView.widthAnchor.constraint(equalToConstant: 5),
            pointView.heightAnchor.constraint(equalToConstant: 5),
            pointView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 22),
            pointView.trailingAnchor.constraint(equalTo: self.pointLabel.leadingAnchor,constant: -10),
            pointView.topAnchor.constraint(equalTo: self.pointLabel.topAnchor,constant: 7),
            pointLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            pointLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
            pointLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor   , constant: -35),



        ])
    }
    
}

// MARK: - Public
extension LogoffListViewCell {
    
}

// MARK: - Action
@objc private extension LogoffListViewCell {
    
}

// MARK: - Private
private extension LogoffListViewCell {
    
}
