//
//  CabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetListViewController: BaseViewController{
    
    // MARK: - Accessor
    var items:[CabinetSummary] = [CabinetSummary](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        tableView.register(CabinetListViewCell.self, forCellReuseIdentifier: CabinetListViewCell.cellIdentifier())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupNavbar()
        setupSubviews()
        setupLayout()
        
    }
    
}

// MARK: - Setup
private extension CabinetListViewController {
    
    private func setupNavbar() {
        self.title = "电柜列表"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
}

// MARK: - Public
extension CabinetListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回单元格数量
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 配置单元格
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CabinetListViewCell.cellIdentifier(), for: indexPath) as? CabinetListViewCell else {return CabinetListViewCell()}
        // 设置单元格的内容，如文本等
//        cell.textLabel?.text = "Cabinet \(indexPath.row)"
        cell.item = self.items[indexPath.row]
        return cell
    }
    
    
}

// MARK: - Request
private extension CabinetListViewController {
    
}

// MARK: - Action
@objc private extension CabinetListViewController {
    
}

// MARK: - Private
private extension CabinetListViewController {
    
}
