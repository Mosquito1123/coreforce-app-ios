//
//  FirstContentViewController.swift
//  hfpower
//
//  Created by EDY on 2024/10/14.
//

import UIKit
import FloatingPanel
class FirstContentViewController: UIViewController {
    var fpc:FloatingPanelController?
    // MARK: - Accessor
    var items:[FirstContent] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PersonalHeaderViewCell.self, forCellReuseIdentifier: PersonalHeaderViewCell.cellIdentifier())
        tableView.register(PersonalPackageCardViewCell.self, forCellReuseIdentifier: PersonalPackageCardViewCell.cellIdentifier())
        tableView.register(PersonalDevicesViewCell.self, forCellReuseIdentifier: PersonalDevicesViewCell.cellIdentifier())
        tableView.register(PersonalAssetsViewCell.self, forCellReuseIdentifier: PersonalAssetsViewCell.cellIdentifier())
        tableView.register(PersonalMileageViewCell.self, forCellReuseIdentifier: PersonalMileageViewCell.cellIdentifier())
        tableView.register(PersonalOthersViewCell.self, forCellReuseIdentifier: PersonalOthersViewCell.cellIdentifier())
        tableView.register(AuthorityViewCell.self, forCellReuseIdentifier: AuthorityViewCell.cellIdentifier())
        
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

        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
    }
    func loadData(){
        self.items = YourClass().items
    }
}

// MARK: - Setup
private extension FirstContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex: 0xF7F7F7FF)
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
extension FirstContentViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.items[indexPath.section].items?[indexPath.row],let identifier = item.identifier else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
}

// MARK: - Request
private extension FirstContentViewController {
    
}

// MARK: - Action
@objc private extension FirstContentViewController {
    
}

// MARK: - Private
private extension FirstContentViewController {
    
}
class YourClass {
    var items: [FirstContent] = []

    init() {
        // 使用循环生成 100 个 FirstContent
        for i in 0..<100 {
            let content = FirstContent(id: i, title: "内容 \(i)", items: [
                FirstContentItem(id: 0, identifier: PersonalPackageCardViewCell.cellIdentifier(), title: "购买套餐 \(i)")
            ])
            items.append(content)
        }
    }
}
