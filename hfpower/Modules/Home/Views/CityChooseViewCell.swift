//
//  CityChooseViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import UIKit

class CityChooseViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> CityChooseViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CityChooseViewCell { return cell }
        return CityChooseViewCell(style: .default, reuseIdentifier: identifier)
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
private extension CityChooseViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension CityChooseViewCell {
    
}

// MARK: - Action
@objc private extension CityChooseViewCell {
    
}

// MARK: - Private
private extension CityChooseViewCell {
    
}
