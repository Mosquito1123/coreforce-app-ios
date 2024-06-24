//
//  PersonalOthersViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalOthersViewCell: PersonalContentViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PersonalOthersViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalOthersViewCell { return cell }
        return PersonalOthersViewCell(style: .default, reuseIdentifier: identifier)
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
private extension PersonalOthersViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension PersonalOthersViewCell {
    
}

// MARK: - Action
@objc private extension PersonalOthersViewCell {
    
}

// MARK: - Private
private extension PersonalOthersViewCell {
    
}
