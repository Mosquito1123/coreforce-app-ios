//
//  BatteryReplacementViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class BatteryReplacementViewController: BaseTableViewController<BatteryReplacementStatusViewCell,BatteryReplacementStatus> {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var bottomView: BatteryReplacementBottomView = {
        let view = BatteryReplacementBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Setup
private extension BatteryReplacementViewController {
    
    private func setupNavbar() {
        self.title = "电池租赁"
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        let footerView = BatteryReplacementTableFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
        self.tableView.tableFooterView = footerView
        self.view.addSubview(self.tableView)
        self.view.addSubview(bottomView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}

// MARK: - Public
extension BatteryReplacementViewController {
    
}

// MARK: - Request
private extension BatteryReplacementViewController {
    
}

// MARK: - Action
@objc private extension BatteryReplacementViewController {
    
}

// MARK: - Private
private extension BatteryReplacementViewController {
    
}
