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
        tableView.register(BoughtPlansViewCell.self, forCellReuseIdentifier: BoughtPlansViewCell.cellIdentifier())
        tableView.register(FeeDetailViewCell.self, forCellReuseIdentifier: FeeDetailViewCell.cellIdentifier())
        tableView.register(RecommendViewCell.self, forCellReuseIdentifier: RecommendViewCell.cellIdentifier())
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [BuyPackageCardModel(title: "电池型号",subtitle: "64V36AH", identifier: BatteryTypeViewCell.cellIdentifier(), icon: UIImage(named: "battery_type")),BuyPackageCardModel(title: "换电不限次套餐",subtitle: "64V36AH", identifier: BuyPackageCardPlansViewCell.cellIdentifier()),BuyPackageCardModel(title: "已购套餐",subtitle: "299元/30天", identifier: BoughtPlansViewCell.cellIdentifier()),BuyPackageCardModel(title: "费用结算",subtitle: "299元/30天", identifier: FeeDetailViewCell.cellIdentifier()),BuyPackageCardModel(title: "推荐码（选填）",subtitle: "点击输入或扫描二维码", identifier: RecommendViewCell.cellIdentifier())]
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
            cellx.items = [PackageCard(),PackageCard()]
        }else if let cellx = cell as? BoughtPlansViewCell{
            cellx.titleLabel.text = item.title
            cellx.contentLabel.text = item.subtitle
        }else if let cellx = cell as? FeeDetailViewCell{
            cellx.titleLabel.text = item.title
        }else if let cellx = cell as? RecommendViewCell{
            cellx.titleLabel.text = item.title
            cellx.textField.attributedPlaceholder = NSAttributedString(
                string: item.subtitle ?? "",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16),
                    .foregroundColor: UIColor(rgba: 0xA0A0A0FF)
                ]
            )
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