//
//  LimitedTimePackageCardViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class LimitedTimePackageCardViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> LimitedTimePackageCardViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LimitedTimePackageCardViewCell { return cell }
        return LimitedTimePackageCardViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup
private extension LimitedTimePackageCardViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension LimitedTimePackageCardViewCell {
    
}

// MARK: - Action
@objc private extension LimitedTimePackageCardViewCell {
    
}

// MARK: - Private
private extension LimitedTimePackageCardViewCell {
    
}
