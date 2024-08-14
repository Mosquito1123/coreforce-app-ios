//
//  DepositManagementViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import UIKit

class DepositManagementViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DepositManagementCell.cellIdentifier(), for: indexPath) as? DepositManagementCell else {return DepositManagementCell()}
        cell.element = self.items[indexPath.section].items[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    var items = [DepositManagement]()

    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DepositManagementCell.self, forCellReuseIdentifier: DepositManagementCell.cellIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = UIColor(rgba:0xF7F8FAFF)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension DepositManagementViewController {
    
    private func setupNavbar() {
        self.title = "押金管理"
    }
   
    private func setupSubviews() {
        view.addSubview(tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

// MARK: - Public
extension DepositManagementViewController {
    
}

// MARK: - Request
private extension DepositManagementViewController {
    
}

// MARK: - Action
@objc private extension DepositManagementViewController {
    
}

// MARK: - Private
private extension DepositManagementViewController {
    
}
