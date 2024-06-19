//
//  CabinetPanelViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/19.
//

import UIKit

class CabinetPanelViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var cabinetPanelView: CabinetPanelView = {
        var panelView = CabinetPanelView()
        panelView.translatesAutoresizingMaskIntoConstraints = false
        return panelView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension CabinetPanelViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        view.addSubview(self.cabinetPanelView)
        self.cabinetPanelView.statisticView.showTop = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cabinetPanelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cabinetPanelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cabinetPanelView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            cabinetPanelView.heightAnchor.constraint(equalToConstant: 364),

        ])
    }
}

// MARK: - Public
extension CabinetPanelViewController {
    
}

// MARK: - Request
private extension CabinetPanelViewController {
    
}

// MARK: - Action
@objc private extension CabinetPanelViewController {
    
}

// MARK: - Private
private extension CabinetPanelViewController {
    
}
