//
//  AllPackageCardViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
class AllPackageCardViewController:BaseViewController{
    public let content = AllPackageCardContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "套餐"
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
class AllPackageCardContentViewController: UIViewController {
    
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
private extension AllPackageCardContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension AllPackageCardContentViewController {
    
}

// MARK: - Request
private extension AllPackageCardContentViewController {
    
}

// MARK: - Action
@objc private extension AllPackageCardContentViewController {
    
}

// MARK: - Private
private extension AllPackageCardContentViewController {
    
}
