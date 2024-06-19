//
//  SettingsViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var hasLogoutBlock:(()->Void)?
    var items = [String]()
    private var debounce:Debounce?

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
        self.debounce  = Debounce(interval: 0.2)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = ["退出登录"]
        self.tableView.reloadData()
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
        if self.isViewLoaded{
            self.debounce?.call {
                self.logoutBehavior()

            }
        }
    }
    
    
}

// MARK: - Request
private extension SettingsViewController {
    func logoutBehavior(){
        NetworkService<AuthAPI,BlankResponse>().request(.logout) { result in
            switch result {
            case.success:
                NotificationCenter.default.post(name: .userLoggedOut, object: nil)
                self.navigationController?.popViewController(animated: true)
                self.hasLogoutBlock?()
                
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)

                
            }
        }
    }
}

// MARK: - Action
@objc private extension SettingsViewController {
    
}

// MARK: - Private
private extension SettingsViewController {
    
}
