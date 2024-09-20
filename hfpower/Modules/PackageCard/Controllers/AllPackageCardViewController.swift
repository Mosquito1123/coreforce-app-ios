//
//  AllPackageCardViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
import MJRefresh
class AllPackageCardViewController:BaseViewController{
    public let content = AllPackageCardContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "套餐"
        addChild(content)
        
        self.view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            content.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor) // 示例：设置固定高度
        ])
        
        content.didMove(toParent: self)
        self.navigationController?.isNavigationBarHidden = false
        setupNavbar()
    }
    private func setupNavbar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
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
}
class AllPackageCardContentViewController: TabmanViewController {
    
    // MARK: - Accessor
    let items: [(menu: String, content: UIViewController)] = [(status:0,title:"可用"),(status:1,title:"已用"),(status:2,title:"已过期")].map {
        let title = $0.title
        let vc = AllPackageCardListViewController()
        vc.status = $0.status
        return (menu: title, content: vc)
    }
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension AllPackageCardContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .flat(color: .white)
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = .clear
        bar.buttons.customize { button in
     
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.font = UIFont.systemFont(ofSize: 15)
            button.tintColor = UIColor(hex:0x666666FF)
            button.selectedTintColor = UIColor(hex:0x3171EFFF)

        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension AllPackageCardContentViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return items.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return items[index].content
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = items[index].menu
        return TMBarItem(title: title)
    }
}

// MARK: - Request
private extension AllPackageCardContentViewController {
    
}

// MARK: - Action
@objc private extension AllPackageCardContentViewController {
    
}

// MARK: - Private
private extension AllPackageCardContentViewController {
    
}
class AllPackageCardListViewController:BaseTableViewController<AllPackageCardListViewCell,HFPackageCardModel>{
    
    
    
    // MARK: - Accessor
    var status = 0 //[(status:0,title:"可用"),(status:1,title:"已用"),(status:2,title:"已过期")]
    var pageNum = 1
    var pageCount = 1
    // MARK: - Subviews
    
    // 懒加载的 TableView
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        setupRefreshControl()
        loadData()
    }
    func setupRefreshControl() {
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshing))
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshing))
    }
    @objc func headerRefreshing() {
        // Implement your header refresh logic here
        // ...
        self.items.removeAll()
        pageNum = 1
        self.getData(packageCardListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel] ?? []).filter { $0.status.intValue == self.status }
                self.pageNum = 1
                
                let total = pageResult["total"] as? NSNumber ?? 0
                let size = pageResult["size"] as? NSNumber ?? 1
                
                self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.resetNoMoreData()
        }

        

    }

    @objc func footerRefreshing() {
        // Implement your footer refresh logic here
        // ...
        if pageNum + 1 > pageCount {
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            return
        }
        pageNum = pageNum + 1
        self.getData(packageCardListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                let addItems = (HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel] ?? []).filter { $0.status.intValue == self.status }
                self.items.append(contentsOf: addItems)
                self.tableView.mj_footer?.endRefreshing()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_footer?.endRefreshing()
        }
        

    }
    func loadData(){
        pageNum = 1
        self.getData(packageCardListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel] ?? []).filter { $0.status.intValue == self.status }
                self.pageNum = 1
                
                let total = pageResult["total"] as? NSNumber ?? 0
                let size = pageResult["size"] as? NSNumber ?? 1
                
                self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_footer?.resetNoMoreData()
        }
       

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? AllPackageCardListViewCell{
            cellx.useNowBlock = { render in
            }
        }
    }
    
}

// MARK: - Setup
private extension AllPackageCardListViewController {
    
    private func setupNavbar() {
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.tableView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
