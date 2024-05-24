//
//  LoginPhoneViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/24.
//

import UIKit

class LoginPhoneViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}

// MARK: - Setup
private extension LoginPhoneViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension LoginPhoneViewController {
    
}

// MARK: - Request
private extension LoginPhoneViewController {
    
}

// MARK: - Action
@objc private extension LoginPhoneViewController {
    
}

// MARK: - Private
private extension LoginPhoneViewController {
    
}
