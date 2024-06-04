//
//  SearchCabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit

class SearchCabinetListViewController: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var headerView: SearchCabinetListHeaderView = {
        let view = SearchCabinetListHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var locationView:CabinetLocationView = {
        let view = CabinetLocationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(CabinetListViewCell.self, forCellReuseIdentifier: CabinetListViewCell.cellIdentifier())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "F7F7F7")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
}

// MARK: - Setup
private extension SearchCabinetListViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        view.addSubview(headerView)
        headerView.backAction = {bt in
            self.navigationController?.popViewController(animated: true)
            
        }
        view.addSubview(locationView)
        view.addSubview(tableView)
       
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 44),
            locationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        ])
    }
}

// MARK: - Public
extension SearchCabinetListViewController:UITableViewDelegate,UITableViewDataSource {
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
private extension SearchCabinetListViewController {
    
}

// MARK: - Action
@objc private extension SearchCabinetListViewController {
    
}

// MARK: - Private
private extension SearchCabinetListViewController {
    
}
