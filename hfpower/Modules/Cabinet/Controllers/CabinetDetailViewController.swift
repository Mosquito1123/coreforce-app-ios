//
//  CabinetDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit

class CabinetDetailViewController: UIViewController {
    
    // MARK: - Accessor
    var cabinet:CabinetSummary?{
        didSet{
        }
    }
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
private extension CabinetDetailViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension CabinetDetailViewController {
    
}

// MARK: - Request
private extension CabinetDetailViewController {
    
}

// MARK: - Action
@objc private extension CabinetDetailViewController {
    
}

// MARK: - Private
private extension CabinetDetailViewController {
    
}
