//
//  CabinetDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit
import FSPagerView
import FloatingPanel
class CabinetDetailViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    let fpc = FloatingPanelController()
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
        fpc.delegate = self
        fpc.set(contentViewController: self.cabinetDetailContentController)
        fpc.contentInsetAdjustmentBehavior = .always
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 15.0
            return appearance
        }()
        fpc.addPanel(toParent: self)
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
extension CabinetDetailViewController:FloatingPanelControllerDelegate{
    func floatingPanel(_ fpc: FloatingPanelController, shouldAllowToScroll scrollView: UIScrollView, in state: FloatingPanelState) -> Bool {
        return state == .half || state == .full
    }

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
