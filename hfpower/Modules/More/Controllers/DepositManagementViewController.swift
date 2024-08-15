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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? DepositManagementCell{
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cellx.cornerType = .all
            } else {
                if indexPath.row == 0 {
                    cellx.cornerType = .first
                    
                } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                    cellx.cornerType = .last
                    
                }else{
                    cellx.cornerType = .none
                    
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.viewIdentifier()) as? SettingsHeaderView else {return UIView()}
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16
    }
    var items = [DepositManagement](){
        didSet{
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DepositManagementCell.self, forCellReuseIdentifier: DepositManagementCell.cellIdentifier())
        tableView.register(DepositManagementHeaderView.self, forHeaderFooterViewReuseIdentifier: DepositManagementHeaderView.viewIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgba:0xF7F7F7FF)
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
        self.items = [
            DepositManagement(id: 0,title: "",items: [
                DepositManagementItem(id: 0, title: "租赁中的电池", content: "0",type: 0),
                DepositManagementItem(id: 1, title: "押金", content: "0", selected: true,type: 1),

            ]),
            DepositManagement(id: 1,title: "",items: [
                DepositManagementItem(id: 0, title: "租赁中的电车", content: "1",type: 0),
                DepositManagementItem(id: 1, title: "押金", content: "0", selected: true,type: 2),

            ]),
        ]
    }
    
}

// MARK: - Setup
private extension DepositManagementViewController {
    
    private func setupNavbar() {
        self.title = "押金管理"
    }
   
    private func setupSubviews() {
        view.backgroundColor = .white
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
