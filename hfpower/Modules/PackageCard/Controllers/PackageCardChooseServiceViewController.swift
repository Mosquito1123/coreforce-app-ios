//
//  PackageCardChooseServiceViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class PackageCardChooseServiceViewController: BaseViewController {
    
    // MARK: - Accessor
    var items:[PackageCardChooseService] = [PackageCardChooseService](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var titleAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var titleButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .semibold)
        button.setTitle(CityCodeManager.shared.cityName, for: .normal)
        button.setTitle(CityCodeManager.shared.cityName, for: .highlighted)
        button.setImage(UIImage(named: "search_list_icon_location"), for: .normal)
        button.setImage(UIImage(named: "search_list_icon_location"), for: .highlighted)
        button.addTarget(self, action: #selector(titleButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PackageCardChooseServiceViewCell.self, forCellReuseIdentifier: PackageCardChooseServiceViewCell.cellIdentifier())
       

        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleButton.setImagePosition(type: .imageLeft, Space: 6)
    }
    
}

// MARK: - Setup
private extension PackageCardChooseServiceViewController {
    
    private func setupNavbar() {
        self.navigationItem.titleView = titleButton
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - Public
extension PackageCardChooseServiceViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageCardChooseServiceViewCell.cellIdentifier(), for: indexPath) as? PackageCardChooseServiceViewCell else {return PackageCardChooseServiceViewCell()}
        cell.element = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Request
private extension PackageCardChooseServiceViewController {
    
}

// MARK: - Action
@objc private extension PackageCardChooseServiceViewController {
    @objc func titleButtonTapped(_ sender:UIButton){
        self.titleAction?(sender)
    }
}

// MARK: - Private
private extension PackageCardChooseServiceViewController {
    
}
