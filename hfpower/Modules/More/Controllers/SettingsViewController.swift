//
//  SettingsViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit
import SVProgressHUD
class SettingsViewController: UIViewController {
    
    // MARK: - Accessor
    var items = [String]()

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

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension SettingsViewController {
    
    private func setupNavbar() {
        self.title = "设置"
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
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalViewCell.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NetworkService<AuthAPI>().request(.logout, model: BlankResponse.self) { result in
            switch result {
            case.success(let response):
                TokenManager.shared.clearTokens()
                AccountManager.shared.clearAccount()
                self.tabBarController?.selectedIndex = 0
                
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)

                
            }
        }
    } 
    
    
}

// MARK: - Request
private extension SettingsViewController {
    
}

// MARK: - Action
@objc private extension SettingsViewController {
    
}

// MARK: - Private
private extension SettingsViewController {
    
}
