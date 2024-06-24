//
//  AuthorityViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class AuthorityViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var sureAction:ButtonActionBlock?

    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> AuthorityViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AuthorityViewCell { return cell }
        return AuthorityViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundView = UIImageView(image: UIImage(named: "authority_button_bg"))
        self.selectedBackgroundView = UIImageView(image: UIImage(named: "authority_button_bg"))
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension AuthorityViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension AuthorityViewCell {
    
}

// MARK: - Action
@objc private extension AuthorityViewCell {
    
}

// MARK: - Private
private extension AuthorityViewCell {
    
}
