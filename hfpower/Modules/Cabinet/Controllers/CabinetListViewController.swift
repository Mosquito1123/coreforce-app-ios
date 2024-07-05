//
//  CabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetListViewController: UIViewController{
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var tableView:UITableView = {
        let tableView = UITableView()
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

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension CabinetListViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension CabinetListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回单元格数量
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 配置单元格
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CabinetListViewCell.cellIdentifier(), for: indexPath) as? CabinetListViewCell else {return CabinetListViewCell()}
        // 设置单元格的内容，如文本等
//        cell.textLabel?.text = "Cabinet \(indexPath.row)"
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
