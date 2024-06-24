//
//  MyViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class PersonalViewController: UIViewController {
    
    // MARK: - Accessor
    var items = [PersonalListModel]()
    var accountObservation:NSKeyValueObservation?
    
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonalViewCell.self, forCellReuseIdentifier: PersonalViewCell.cellIdentifier())
        tableView.register(PersonalHeaderViewCell.self, forCellReuseIdentifier: PersonalHeaderViewCell.cellIdentifier())
        tableView.register(PersonalPackageCardViewCell.self, forCellReuseIdentifier: PersonalPackageCardViewCell.cellIdentifier())
        tableView.register(PersonalDevicesViewCell.self, forCellReuseIdentifier: PersonalDevicesViewCell.cellIdentifier())

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
        accountObservation = AccountManager.shared.observe(\.phoneNum, options: [.old,.new,.initial], changeHandler: { accountManager, change in
            if let newName = change.newValue,let x = newName {
                //                print("Name changed to \(x)")
                debugPrint(x)
            }
        })
        self.items = [PersonalListModel(title: "头部",cellHeight: 112, identifier: PersonalHeaderViewCell.cellIdentifier(),action: { sender in
            let settings = SettingsViewController()
            settings.hasLogoutBlock = {
                self.tabBarController?.selectedIndex = 0
            }
            self.navigationController?.pushViewController(settings, animated: true)
        }),PersonalListModel(title: "套餐卡",cellHeight: 71, identifier: PersonalPackageCardViewCell.cellIdentifier(),action: { sender in
            
        }),PersonalListModel(title: "我的设备",cellHeight: 198, identifier: PersonalDevicesViewCell.cellIdentifier(),action: { sender in
            
        }),PersonalListModel(title: "我的资产",cellHeight: 120, identifier: PersonalDevicesViewCell.cellIdentifier(),action: { sender in
            
        }),PersonalListModel(title: "我的里程",cellHeight: 120, identifier: PersonalDevicesViewCell.cellIdentifier(),action: { sender in
            
        }),PersonalListModel(title: "其他服务",cellHeight: 120, identifier: PersonalDevicesViewCell.cellIdentifier(),action: { sender in
            
        })]
        self.tableView.reloadData()
    }
    deinit {
        accountObservation?.invalidate()
    }
    
}

// MARK: - Setup
private extension PersonalViewController {
    
    private func setupNavbar() {
        self.title = "我的"
    }
    
    private func setupSubviews() {
        let bgView = PersonalViewBackgroundView(frame: self.view.bounds)
        view.addSubview(bgView)
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
extension PersonalViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        let action = item.action
        guard let identifier = item.identifier else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let headerCell = cell as? PersonalHeaderViewCell{
            headerCell.settingsAction = action
        }else if let contentCell = cell as? PersonalDevicesViewCell{
            contentCell.titleLabel.text = item.title
        }
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.items[indexPath.row]
        return item.cellHeight ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}

// MARK: - Request
private extension PersonalViewController {
    
}

// MARK: - Action
@objc private extension PersonalViewController {
    
}

// MARK: - Private
private extension PersonalViewController {
    
}
