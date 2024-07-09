//
//  LowPowerReminderViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LowPowerReminderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var items = [LowPowerReminder](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LowPowerReminderListViewCell.self, forCellReuseIdentifier: LowPowerReminderListViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
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
            LowPowerReminder(id: 0, title: "APP通知提醒",content: "电量首次低于30%/20%/10%触发",selected: true),
            LowPowerReminder(id: 1, title: "短信提醒",content: "电量首次低于30%/20%/10%触发",selected: false),
            LowPowerReminder(id: 2, title: "微信公众号提醒",content: "电量首次低于30%/20%/10%触发",selected: false),
            LowPowerReminder(id: 3, title: "低电量提醒勿扰模式",content: "开启后，23:00-次日06:00将不再提醒",selected: false),
          
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
private extension LowPowerReminderViewController {
    
    private func setupNavbar() {
        self.title = "低电量消息提醒设置"
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
        self.view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        self.view.addSubview(self.tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - Public
extension LowPowerReminderViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LowPowerReminderListViewCell.cellIdentifier(), for: indexPath) as? LowPowerReminderListViewCell else {return LowPowerReminderListViewCell()}
        cell.element = self.items[indexPath.row]
        cell.switchAction = { aswitch in 
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
}

// MARK: - Request
private extension LowPowerReminderViewController {
    
}

// MARK: - Action
@objc private extension LowPowerReminderViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension LowPowerReminderViewController {
    
}
