//
//  PackageCardChooseServiceViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class PackageCardChooseServiceViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var element:PackageCardChooseService?{
        didSet{
            
        }
    }
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> PackageCardChooseServiceViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PackageCardChooseServiceViewCell { return cell }
        return PackageCardChooseServiceViewCell(style: .default, reuseIdentifier: identifier)
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
private extension PackageCardChooseServiceViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension PackageCardChooseServiceViewCell {
    
}

// MARK: - Action
@objc private extension PackageCardChooseServiceViewCell {
    
}

// MARK: - Private
private extension PackageCardChooseServiceViewCell {
    
}
