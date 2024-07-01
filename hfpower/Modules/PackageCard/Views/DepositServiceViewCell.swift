//
//  DepositServiceViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/1.
//

import UIKit

class DepositServiceViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> DepositServiceViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DepositServiceViewCell { return cell }
        return DepositServiceViewCell(style: .default, reuseIdentifier: identifier)
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
private extension DepositServiceViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(containerView)
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension DepositServiceViewCell {
    
}

// MARK: - Action
@objc private extension DepositServiceViewCell {
    
}

// MARK: - Private
private extension DepositServiceViewCell {
    
}
