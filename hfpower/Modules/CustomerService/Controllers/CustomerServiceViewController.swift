//
//  CustomerServiceViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit

class CustomerServiceViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
}

// MARK: - Setup
private extension CustomerServiceViewController {
    
    private func setupNavbar() {
        self.title = "客服"
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension CustomerServiceViewController {
    
}

// MARK: - Request
private extension CustomerServiceViewController {
    
}

// MARK: - Action
@objc private extension CustomerServiceViewController {
    
}

// MARK: - Private
private extension CustomerServiceViewController {
    
}
