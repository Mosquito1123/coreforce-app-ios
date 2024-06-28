//
//  BuyPackageCardPlansViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit

class BuyPackageCardPlansViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> BuyPackageCardPlansViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BuyPackageCardPlansViewCell { return cell }
        return BuyPackageCardPlansViewCell(style: .default, reuseIdentifier: identifier)
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
private extension BuyPackageCardPlansViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BuyPackageCardPlansViewCell {
    
}

// MARK: - Action
@objc private extension BuyPackageCardPlansViewCell {
    
}

// MARK: - Private
private extension BuyPackageCardPlansViewCell {
    
}
