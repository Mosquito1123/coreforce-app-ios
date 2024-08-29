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
        tableView.backgroundColor = UIColor(rgba:0xF7F7F7FF)
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
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//
//        
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        
//    }
    
    
}

// MARK: - Setup
private extension SearchCabinetListViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        headerView.backAction = {bt in
            self.navigationController?.popViewController(animated: true)
            
        }
        self.navigationItem.titleView = headerView
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "search_list_icon_arrow_back"), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        // 设置背景色为白色
        appearance.backgroundImage = UIColor.white.toImage()
        appearance.shadowImage = UIColor.white.toImage()
        
        
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
   
    private func setupSubviews() {
//        view.addSubview(headerView)
        
        
        view.addSubview(locationView)
        view.addSubview(tableView)
       
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),
//            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension SearchCabinetListViewController {
    
}
