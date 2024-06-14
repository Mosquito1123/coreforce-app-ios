//
//  MyViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class PersonalViewController: UIViewController {
    
    // MARK: - Accessor
    var items = [String]()
    var accountObservation:NSKeyValueObservation?

    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.register(PersonalViewCell.self, forCellReuseIdentifier: PersonalViewCell.cellIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = UIColor(named: "F7F8FA")
        tableView.delegate = self
        tableView.dataSource = self
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
        self.items = ["设置"]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalViewCell.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let settings = SettingsViewController()
        settings.title = self.items[indexPath.row]
        settings.hasLogoutBlock = {
            self.tabBarController?.selectedIndex = 0
        }
        self.navigationController?.pushViewController(settings, animated: true)
        
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
