//
//  MyPackageCardListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class MyPackageCardListViewCell: BaseTableViewCell<PackageCard> {
    
    // MARK: - Accessor
    override func configure() {
        guard let item = element else {return}
    
    }
    // MARK: - Subviews
    lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> MyPackageCardListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageCardListViewCell { return cell }
        return MyPackageCardListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension MyPackageCardListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension MyPackageCardListViewCell {
    
}

// MARK: - Action
@objc private extension MyPackageCardListViewCell {
    
}

// MARK: - Private
private extension MyPackageCardListViewCell {
    
}
