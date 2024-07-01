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
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BatteryTypeViewCell.self, forCellReuseIdentifier: BatteryTypeViewCell.cellIdentifier())
        tableView.register(BuyPackageCardPlansViewCell.self, forCellReuseIdentifier: BuyPackageCardPlansViewCell.cellIdentifier())

        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [BuyPackageCardModel(title: "电池型号",subtitle: "64V36AH", identifier: BatteryTypeViewCell.cellIdentifier(), icon: UIImage(named: "battery_type")),BuyPackageCardModel(title: "换电不限次套餐",subtitle: "64V36AH", identifier: BuyPackageCardPlansViewCell.cellIdentifier(), icon: UIImage(named: "battery_type"))]
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
        let item = self.items[indexPath.row]
        guard let identifier = item.identifier else {return UITableViewCell()}

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cellx = cell as? BatteryTypeViewCell{
            cellx.iconImageView.image = item.icon
            cellx.titleLabel.text = item.title
            cellx.contentLabel.text = item.subtitle

        }else if let cellx = cell as? BuyPackageCardPlansViewCell{
            cellx.titleLabel.text = item.title
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
