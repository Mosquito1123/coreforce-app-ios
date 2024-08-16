//
//  AboutViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class AboutViewController: BaseViewController {
    
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
            About(id: 3, title: "ICP备案号",content: "鲁ICP备19025494号-2A"),
            About(id: 4, title: "网站",content: "https://www.coreforce.cn"),

            About(id: 5, title: "当前版本",content: majorVersion ?? ""),

          
        ]
    }
    
}

// MARK: - Setup
private extension AboutViewController {
    
    private func setupNavbar() {
        self.title = "关于我们"
      
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            if let url = URL(string: "tel://4006789509") {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 4{
            if let url = URL(string: "https://www.coreforce.cn") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
// MARK: - Request
private extension AboutViewController {
    
}

// MARK: - Action
@objc private extension AboutViewController {
    
}

// MARK: - Private
private extension AboutViewController {
    
}
