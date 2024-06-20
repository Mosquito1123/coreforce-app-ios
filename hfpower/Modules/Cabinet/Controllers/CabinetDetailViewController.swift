//
//  CabinetDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit
import FSPagerView
class CabinetDetailViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var cabinetAnnotation:CabinetAnnotation?{
        didSet{
        }
    }
    let cabinetDetailContentController = CabinetDetailContentViewController()
    // MARK: - Subviews
    lazy var bottomView: CabinetDetailBottomView = {
        let view = CabinetDetailBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton(type:.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.backgroundColor = .white
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
        self.addChild(cabinetDetailContentController)
        self.view.addSubview(cabinetDetailContentController.view)
        cabinetDetailContentController.view.frame = self.view.bounds
        cabinetDetailContentController.didMove(toParent: self)
        self.view.addSubview(self.bottomView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 73+34),

        ])
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
