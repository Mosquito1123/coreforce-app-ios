//
//  OrderListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
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
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize.init(width: 12, height: 20)), for: .normal)  // 设置自定义图片
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
    let items: [(menu: String, content: UIViewController)] = ["全部","已支付","已取消/过期"].map {
        let title = $0
        let vc = OrderListViewController()
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
    var index = 0
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [OrderList(),OrderList()]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailViewController = OrderDetailViewController()
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
