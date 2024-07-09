//
//  LogOffViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogOffViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var items = [Logoff](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews\
    lazy var bottomView: LogoffBottomView = {
        let view = LogoffBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LogoffListViewCell.self, forCellReuseIdentifier: LogoffListViewCell.cellIdentifier())
        tableView.tableFooterView = LogoffTableFooterView()
        tableView.tableHeaderView = LogoffTableHeaderView()
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = UIColor.white
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
        self.items = [
            Logoff(id: 0, title: "注销后将无法使用核蜂动力下的核蜂动力app、核蜂动力小程序等"),
            Logoff(id: 1, title: "身份及账户信息将被清空"),
            Logoff(id: 2, title: "优惠券将被清空"),
            Logoff(id: 3, title: "所有的交易记录等将被清空"),
            Logoff(id: 4, title: "所有的邀请奖励将被清空"),
            Logoff(id: 5, title: "注销前请及时退租已租的电池和电车，以免产生法律纠纷"),
            Logoff(id: 6, title: "注销前请及时退款已购套餐，以免给您造成不必要的经济损失"),
        ]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIColor.white.toImage(), for: .default)
            navigationBar.shadowImage = UIColor.white.toImage()
            
            // 设置标题字体和颜色
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(rgba:0x333333FF),
                .font: UIFont.systemFont(ofSize: 18,weight: .medium)
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
            
            // 恢复标题字体和颜色
            navigationBar.titleTextAttributes = nil
        }
    }
}

// MARK: - Setup
private extension LogOffViewController {
    
    private func setupNavbar() {
        self.title = "注销账号"
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
        self.view.addSubview(self.bottomView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor),
            self.bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 93),
        ])
    }
}

// MARK: - Public
extension LogOffViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoffListViewCell.cellIdentifier(), for: indexPath) as? LogoffListViewCell else {return LogoffListViewCell()}
        cell.element = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
}

// MARK: - Request
private extension LogOffViewController {
    
}

// MARK: - Action
@objc private extension LogOffViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension LogOffViewController {
    
}