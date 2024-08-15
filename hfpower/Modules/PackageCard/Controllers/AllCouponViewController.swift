//
//  AllCouponViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
class AllCouponViewController:BaseViewController{
    public let content = AllCouponContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "优惠券"
        addChild(content)
        
        self.view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            content.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor) // 示例：设置固定高度
        ])
        
        content.didMove(toParent: self)
    }
}
class AllCouponContentViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension AllCouponContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension AllCouponContentViewController {
    
}

// MARK: - Request
private extension AllCouponContentViewController {
    
}

// MARK: - Action
@objc private extension AllCouponContentViewController {
    
}

// MARK: - Private
private extension AllCouponContentViewController {
    
}
