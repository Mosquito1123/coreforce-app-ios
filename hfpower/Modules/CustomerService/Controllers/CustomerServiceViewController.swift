//
//  CustomerServiceViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
import Tabman
import Pageboy
class CustomerServiceViewController:BaseViewController{
    public let content = CustomerServiceContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "核蜂客服"
        addChild(content)
        
        self.view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            content.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor) // 示例：设置固定高度
        ])
        
        content.didMove(toParent: self)
        
    }
    func setupNavbar(){
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.tintAdjustmentMode = .automatic
        backButton.setImage(UIImage(named: "back_arrow")?.colorized(with: UIColor.white)?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)  // 设置自定义图片
        backButton.setImage(UIImage(named: "back_arrow")?.colorized(with: UIColor.white)?.resized(toSize: CGSize(width: 20, height: 20)), for: .highlighted)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitle("", for: .highlighted)  // 设置标题
        backButton.setTitleColor(.white, for: .normal)  // 设置标题颜色
        backButton.setTitleColor(.white, for: .highlighted)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        
        // 设置背景色为白色
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font:UIFont.systemFont(ofSize: 18, weight: .semibold)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavbar()
        
    }
}
class CustomerServiceContentViewController: TabmanViewController {
    
    // MARK: - Accessor
    var items: [(menu: HFHelpDict, content: UIViewController)] = [HFHelpDict()].map {
        let model = $0
        let vc = CustomerServicePagerViewController()
        return (menu: model, content: vc)
    }
    
    
    var contactAction:ButtonActionBlock?
    
    // MARK: - Subviews
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "customer_service_background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var contactButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("联系我们", for: .normal)
        button.setTitleColor(UIColor(rgba: 0x447AFEFF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0x447AFEFF), for: .selected)
        button.setImage(UIImage(named: "customer_service_phone"), for: .normal)
        button.setImage(UIImage(named: "customer_service_phone"), for: .highlighted)
        button.setImage(UIImage(named: "customer_service_phone"), for: .selected)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setBackgroundImage(UIColor.white.toImage(), for: .selected)
        button.setBackgroundImage(UIColor.white.toImage(), for: .disabled)
        button.layer.cornerRadius = 24.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(onCalled(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactButton.setImagePosition(type: .imageLeft, Space: 2)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadItems()
    }
    func loadItems(){
        self.getData(helpDictListUrl, param: ["dictType":"SYS_HELP_TYPE"], isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                let helpDictList = (HFHelpDict.mj_objectArray(withKeyValuesArray: dataList) as? [HFHelpDict]) ?? []
                self.items = helpDictList.map {
                    let model = $0
                    let vc = CustomerServicePagerViewController()
                    vc.id = $0.id
                    vc.title = $0.value
                    return (menu: model, content: vc)
                }
                self.reloadData()
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
    }
}

// MARK: - Setup
private extension CustomerServiceContentViewController {
    
    private func setupNavbar() {
        self.title = "核蜂客服"
        
        
    }
    
    
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        self.view.insertSubview(backgroundImageView, at: 0)
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.backgroundView.style = .flat(color: .clear)
        bar.layout.contentMode = .intrinsic
        bar.layout.alignment = .centerDistributed
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = .white
        bar.buttons.customize { button in
            
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.font = UIFont.systemFont(ofSize: 15)
            button.tintColor = UIColor(rgba: 0xFFFFFFFF).withAlphaComponent(0.7)
            button.selectedTintColor = UIColor(rgba: 0xFFFFFFFF)
            
        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
        view.addSubview(contactButton)
        self.view.bringSubviewToFront(contactButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.heightAnchor.constraint(equalToConstant: 300),
            
            self.contactButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.contactButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            self.contactButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -29),
            self.contactButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}

// MARK: - Public

extension CustomerServiceContentViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        let title = items[index].menu.value
        return TMBarItem(title: title)
    }
}
extension CustomerServiceContentViewController {
    
}

// MARK: - Request
private extension CustomerServiceContentViewController {
    
}

// MARK: - Action
@objc private extension CustomerServiceContentViewController {
    @objc func onCalled(_ sender:UIButton){
        if let phoneURL = URL(string: "tel://400-6789-509"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        self.contactAction?(sender)
    }
    @objc func backButtonTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension CustomerServiceContentViewController {
    
}
class CustomerServicePagerViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerServicePagerViewCell.cellIdentifier(), for: indexPath) as? CustomerServicePagerViewCell else {return UITableViewCell()}
        cell.title = self.title
        cell.elements = self.list
        cell.didSelectRowAction = { tableView,indexPath in
            let detailVC = CustomerServiceDetailViewController()
            detailVC.element = self.list[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        return cell
    }
    
    
    // MARK: - Subviews
    
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerServicePagerViewCell.self, forCellReuseIdentifier: CustomerServicePagerViewCell.cellIdentifier())
        
        return tableView
    }()
    @objc var id:NSNumber?
    var list:[HFHelpList] = [HFHelpList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
    }
    func loadData(){
        var params = [String:Any]()
        if let idx = id {
            params["type"] = idx
        }
        self.getData(helpListUrl, param: params, isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                let items = HFHelpList.mj_objectArray(withKeyValuesArray: dataList) as? [HFHelpList] ?? []
                self.list = items
                self.tableView.reloadData()
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
    }
}
private extension CustomerServicePagerViewController{
    private func setupNavbar() {
    }
    private func setupSubviews() {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.tableView)
        
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}
