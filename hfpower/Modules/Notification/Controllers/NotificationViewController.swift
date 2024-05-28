//
//  NotificationViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit

class NotificationViewController: UIViewController {
    
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
private extension NotificationViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension NotificationViewController {
    
}

// MARK: - Request
private extension NotificationViewController {
    
}

// MARK: - Action
@objc private extension NotificationViewController {
    
}

// MARK: - Private
private extension NotificationViewController {
    
}
