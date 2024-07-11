//
//  BaseTableViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class BaseTableViewController<CellType:BaseTableViewCell<ItemType>,ItemType>: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.cellIdentifier(), for: indexPath) as? CellType else { return CellType() }
        cell.element = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - Accessor
    var items: [ItemType] = []{
        didSet{
            self.tableView.reloadData()
            
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.cellIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
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
private extension BaseTableViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension BaseTableViewController{
    
}

// MARK: - Request
private extension BaseTableViewController {
    
}

// MARK: - Action
@objc private extension BaseTableViewController {
    
}

// MARK: - Private
private extension BaseTableViewController {
    
}
