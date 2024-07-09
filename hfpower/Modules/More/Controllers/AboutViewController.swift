//
//  AboutViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class AboutViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var items = [About](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AboutListViewCell.self, forCellReuseIdentifier: AboutListViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        tableView.tableHeaderView = AboutTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 180))
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
        let  majorVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.items = [
            About(id: 0, title: "版权所有",content: "青岛铁骑网络科技有限公司"),
            About(id: 1, title: "微信公众号",content: "核蜂换电"),
            About(id: 2, title: "客服电话",content: "400 6789 509"),
            About(id: 3, title: "ICP备案号",content: "123456789"),
            About(id: 3, title: "网站",content: "123456789"),

            About(id: 3, title: "当前版本",content: majorVersion ?? ""),

          
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
private extension AboutViewController {
    
    private func setupNavbar() {
        self.title = "关于我们"
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
extension AboutViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutListViewCell.cellIdentifier(), for: indexPath) as? AboutListViewCell else {return AboutListViewCell()}
        cell.element = self.items[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
}
// MARK: - Request
private extension AboutViewController {
    
}

// MARK: - Action
@objc private extension AboutViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension AboutViewController {
    
}
