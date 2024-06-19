//
//  CabinetPanelViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/19.
//

import UIKit

class CabinetPanelViewController: UIViewController {
    
    // MARK: - Accessor
    var navigateAction:ButtonActionBlock?
    var scanAction:ButtonActionBlock?
    var dropDownAction:ButtonActionBlock?
    var detailAction:ButtonActionBlock?
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
        self.cabinetPanelView.navigateAction = self.navigateAction
        self.cabinetPanelView.scanAction = self.scanAction
        self.cabinetPanelView.detailAction = self.detailAction
        self.cabinetPanelView.dropDownAction = self.dropDownAction

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cabinetPanelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cabinetPanelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cabinetPanelView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            cabinetPanelView.topAnchor.constraint(equalTo: self.view.topAnchor),

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
