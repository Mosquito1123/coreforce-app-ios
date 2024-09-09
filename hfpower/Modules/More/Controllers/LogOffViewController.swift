//
//  LogOffViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogOffViewController: BaseViewController {
    
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
        let footerView = LogoffTableFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 180))

        // 强制布局并设置 tableHeaderView 的高度
        footerView.layoutIfNeeded()
        tableView.tableFooterView = footerView
        let headerView = LogoffTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 150))

        // 强制布局并设置 tableHeaderView 的高度
        headerView.layoutIfNeeded()
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
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
    
}

// MARK: - Setup
private extension LogOffViewController {
    
    private func setupNavbar() {
        self.title = "注销账号"
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.bottomView.sureAction = { action in
            self.showAlertController(titleText: "提示", messageText: "确定要注销吗？",okAction: {
                
                self.postData(logoutUrl, param: [:], isLoading: true) { responseObject in
                    let loginVC = LoginViewController()
                    let nav = UINavigationController(rootViewController: loginVC)
                    nav.modalPresentationStyle = .fullScreen
                    nav.modalTransitionStyle = .coverVertical
                    let mainController = nav
                    UIViewController.ex_keyWindow()?.rootViewController = mainController
                    HFKeyedArchiverTool.removeData()
                } error: { error in
                    self.showError(withStatus: error.localizedDescription)
                }
            },isCancelAlert: true) {
                
            }
        }
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
     
}

// MARK: - Private
private extension LogOffViewController {
    
}
