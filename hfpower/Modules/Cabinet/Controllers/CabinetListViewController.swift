//
//  CabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetListViewController: UIViewController, UIGestureRecognizerDelegate{
    
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

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 设置导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIColor.white.toImage(), for: .default)
            navigationBar.shadowImage = UIColor.white.toImage()
            navigationBar.tintColor = UIColor.black  // 设置导航栏按钮颜色
            
            // 设置标题字体和颜色
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 20)
            ]
            navigationBar.titleTextAttributes = titleAttributes
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 恢复导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            navigationBar.tintColor = nil  // 恢复默认按钮颜色
            
            // 恢复标题字体和颜色
            navigationBar.titleTextAttributes = nil
        }
    }
}

// MARK: - Setup
private extension CabinetListViewController {
    
    private func setupNavbar() {
        self.title = "电柜列表"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize.init(width: 12, height: 20)), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
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
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension CabinetListViewController {
    
}
