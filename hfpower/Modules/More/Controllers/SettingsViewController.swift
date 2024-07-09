//
//  SettingsViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit

class SettingsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var hasLogoutBlock:(()->Void)?
    var items = [Settings]()
    private var debounce:Debounce?
    
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonalViewCell.self, forCellReuseIdentifier: PersonalViewCell.cellIdentifier())
        tableView.register(SettingsHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderView.viewIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = UIColor(rgba:0xF7F8FAFF)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.debounce  = Debounce(interval: 0.2)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [
            Settings(id: 0,title: "",items: [
                SettingsItem(id: 0, title: "低电量提醒", content: "",type: 0),
                SettingsItem(id: 1, title: "消息通知", content: "关闭后将不再推送所有APP通知", selected: true,type: 1),

            ]),
            Settings(id: 1,title: "",items: [
                SettingsItem(id: 0, title: "修改密码", content: "",type: 0),
                SettingsItem(id: 1, title: "修改手机号", content: "135****1234", selected: true,type: 2),

            ]),
            Settings(id: 2,title: "",items: [
                SettingsItem(id: 0, title: "隐私政策", content: "",type: 0),
                SettingsItem(id: 1, title: "租赁协议", content: "",type: 0),
                SettingsItem(id: 2, title: "关于我们", content: "",type: 0),



            ]),
            Settings(id: 3,title: "",items: [
                SettingsItem(id: 0, title: "注销账号", content: "注销后无法恢复，请谨慎操作",type: 2),
            ]),
            Settings(id: 4,title: "",items: [
                SettingsItem(id: 0, title: "退出登录", content: "",type: 3),
            ]),]
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // 设置导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIColor.white.toImage(), for: .default)
            navigationBar.shadowImage = UIColor.white.toImage()
            
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
            
            // 恢复标题字体和颜色
            navigationBar.titleTextAttributes = nil
        }
    }
}

// MARK: - Setup
private extension SettingsViewController {
    
    private func setupNavbar() {
        self.title = "设置"
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
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.viewIdentifier()) as? SettingsHeaderView else {return UIView()}
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalViewCell.cellIdentifier(), for: indexPath) as? PersonalViewCell else {return PersonalViewCell()}
        cell.element = self.items[indexPath.section].items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? PersonalViewCell{
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cellx.cornerType = .all
            } else {
                if indexPath.row == 0 {
                    cellx.cornerType = .first
                    
                } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                    cellx.cornerType = .last
                    
                }else{
                    cellx.cornerType = .none
                    
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.section].items[indexPath.row]
        if item.title == "注销账号"{
            let logoffViewController = LogOffViewController()
            self.navigationController?.pushViewController(logoffViewController, animated: true)
        }
        if item.type == 3 {
            tableView.deselectRow(at: indexPath, animated: true)
            if self.isViewLoaded{
                self.debounce?.call {
                    self.logoutBehavior()
                    
                }
            }
        }
        
        
    }
    
    
}

// MARK: - Request
private extension SettingsViewController {
    func logoutBehavior(){
        NetworkService<AuthAPI,BlankResponse>().request(.logout) { result in
            switch result {
            case.success:
                NotificationCenter.default.post(name: .userLoggedOut, object: nil)
                self.navigationController?.popViewController(animated: true)
                self.hasLogoutBlock?()
                
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                
                
            }
        }
    }
}

// MARK: - Action
@objc private extension SettingsViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension SettingsViewController {
    
}
