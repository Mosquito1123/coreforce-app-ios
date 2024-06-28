//
//  BuyPackageCardViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit

class BuyPackageCardViewController: UIViewController {
    
    // MARK: - Accessor
    var items = [BuyPackageCardModel]()
    // MARK: - Subviews
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BatteryTypeViewCell.self, forCellReuseIdentifier: BatteryTypeViewCell.cellIdentifier())
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [BuyPackageCardModel(title: "电池型号",subtitle: "64V36AH", icon: UIImage(named: "battery_type"))]
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: - Setup
private extension BuyPackageCardViewController {
    
    private func setupNavbar() {
        self.title = "购买套餐"
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),


        ])
    }
}

// MARK: - Public
extension BuyPackageCardViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BatteryTypeViewCell.cellIdentifier(), for: indexPath)
        if let cellx = cell as? BatteryTypeViewCell{
            cellx.iconImageView.image = self.items[indexPath.row].icon
            cellx.titleLabel.text = self.items[indexPath.row].title
            cellx.contentLabel.text = self.items[indexPath.row].subtitle

        }
        return cell
    }
    
    
}

// MARK: - Request
private extension BuyPackageCardViewController {
    
}

// MARK: - Action
@objc private extension BuyPackageCardViewController {
    
}

// MARK: - Private
private extension BuyPackageCardViewController {
    
}
