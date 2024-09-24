//
//  BaseTableViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit
import EmptyDataSet_Swift
class BaseTableViewController<CellType:BaseTableViewCell<ItemType>,ItemType>: BaseViewController,EmptyDataSetDelegate,EmptyDataSetSource,UITableViewDelegate,UITableViewDataSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "暂无内容",attributes: [.font:UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor(hex: 0x999999FF)])
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "no_data")
    }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
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
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.cellIdentifier())
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 10))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
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
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)  // 设置自定义图片
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
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
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
