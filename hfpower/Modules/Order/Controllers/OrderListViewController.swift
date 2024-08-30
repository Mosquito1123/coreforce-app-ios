//
//  OrderListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
import MJRefresh
class AllOrderViewController:BaseViewController{
    public let content = AllOrderContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
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
        appearance.titleTextAttributes = [.foregroundColor: UIColor(rgba: 0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
}
class AllOrderContentViewController: TabmanViewController {
    
    // MARK: - Accessor
    let items: [(menu: String, content: UIViewController)] = [(payStatus:999,title:"全部"),(payStatus:2,title:"已支付"),(payStatus:0,title:"已取消/过期")].map {
        let title = $0.title
        let vc = OrderListViewController()
        vc.payStatus = $0.payStatus
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
private extension AllOrderContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba:0xF7F7F7FF)
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
            button.tintColor = UIColor(rgba: 0x666666FF)
            button.selectedTintColor = UIColor(rgba: 0x3171EFFF)

        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension AllOrderContentViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return items.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return items[index].content
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = items[index].menu
        return TMBarItem(title: title)
    }
}

// MARK: - Request
private extension AllOrderContentViewController {
    
}

// MARK: - Action
@objc private extension AllOrderContentViewController {
    
}

// MARK: - Private
private extension AllOrderContentViewController {
    
}
class OrderListViewController: BaseTableViewController<OrderListViewCell,OrderList> {
    
    // MARK: - Accessor
    var payStatus = 999
    var pageNum = 1
    var pageCount = 1
    // MARK: - Subviews

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
        NetworkService<BusinessAPI,DataListResponse<OrderList>>().request(.orderList(page: pageNum)) { result in
            switch result {
            case.success(let response):
                self.items = (response?.pageResult?.dataList ?? []).filter { self.payStatus == 999 ? true:$0.payStatus == self.payStatus }
                self.pageNum = 1
                let total = (Double)(response?.pageResult?.total ?? 1)
                let size = (Double)(response?.pageResult?.size ?? 1)
                self.pageCount = Int(ceil(total/size))
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                self.pageNum = 1
                self.pageCount = 1
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
                
            }
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
        NetworkService<BusinessAPI,DataListResponse<OrderList>>().request(.orderList(page: pageNum)) { result in
            switch result {
            case.success(let response):
                let items = (response?.pageResult?.dataList ?? []).filter { self.payStatus == 999 ? true:$0.payStatus == self.payStatus }
                self.items.append(contentsOf: items)
                self.tableView.mj_footer?.endRefreshing()
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                self.tableView.mj_footer?.endRefreshing()

                
            }
        }
    }
    func loadData(){
        pageNum = 1
        NetworkService<BusinessAPI,DataListResponse<OrderList>>().request(.orderList(page: pageNum)) { result in
            switch result {
            case.success(let response):
                self.items = (response?.pageResult?.dataList ?? []).filter { self.payStatus == 999 ? true:$0.payStatus == self.payStatus }
                self.pageNum = 1
                let total = (Double)(response?.pageResult?.total ?? 1)
                let size = (Double)(response?.pageResult?.size ?? 1)
                self.pageCount = Int(ceil(total/size))
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                self.pageNum = 1
                self.pageCount = 1
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailViewController = OrderDetailViewController()
        orderDetailViewController.element = self.items[indexPath.row]
        self.navigationController?.pushViewController(orderDetailViewController, animated: true)
    }
}

// MARK: - Setup
private extension OrderListViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        self.tableView.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
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

// MARK: - Public
extension OrderListViewController {
    
}

// MARK: - Request
private extension OrderListViewController {
    
}

// MARK: - Action
@objc private extension OrderListViewController {
    
}

// MARK: - Private
private extension OrderListViewController {
    
}
