//
//  NewComersPackageCardViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class NewComersPackageCardViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> NewComersPackageCardViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NewComersPackageCardViewCell { return cell }
        return NewComersPackageCardViewCell(style: .default, reuseIdentifier: identifier)
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
private extension NewComersPackageCardViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension NewComersPackageCardViewCell {
    
}

// MARK: - Action
@objc private extension NewComersPackageCardViewCell {
    
}

// MARK: - Private
private extension NewComersPackageCardViewCell {
    
}
