//
//  CabinetDetailContentViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit

class CabinetDetailContentViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var cabinetDetailContentView:CabinetDetailContentView = {
        let view = CabinetDetailContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension CabinetDetailContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.cabinetDetailContentView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cabinetDetailContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cabinetDetailContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cabinetDetailContentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            cabinetDetailContentView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
    }
}

// MARK: - Public
extension CabinetDetailContentViewController {
    
}

// MARK: - Request
private extension CabinetDetailContentViewController {
    
}

// MARK: - Action
@objc private extension CabinetDetailContentViewController {
    
}

// MARK: - Private
private extension CabinetDetailContentViewController {
    
}
