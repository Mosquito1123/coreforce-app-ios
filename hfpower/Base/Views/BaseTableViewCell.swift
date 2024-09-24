//
//  BaseTableViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit
import SwipeCellKit
enum BaseCellCornerType{
    case first
    case last
    case all
    case none
}
class BaseTableViewCell<ItemType>: SwipeTableViewCell {
    
    // MARK: - Accessor
    var element: ItemType? {
        didSet {
            configure()
        }
    }
    
    // 配置 Cell 的方法，需要子类实现
    func configure() {
    }
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> BaseTableViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BaseTableViewCell { return cell }
        return BaseTableViewCell(style: .default, reuseIdentifier: identifier)
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
private extension BaseTableViewCell {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension BaseTableViewCell {
    
}

// MARK: - Action
@objc private extension BaseTableViewCell {
    
}

// MARK: - Private
private extension BaseTableViewCell {
    
}
