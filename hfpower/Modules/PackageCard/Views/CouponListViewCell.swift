//
//  CouponListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class CouponListViewCell: BaseTableViewCell<Coupon> {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> CouponListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CouponListViewCell { return cell }
        return CouponListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension CouponListViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension CouponListViewCell {
    
}

// MARK: - Action
@objc private extension CouponListViewCell {
    
}

// MARK: - Private
private extension CouponListViewCell {
    
}
