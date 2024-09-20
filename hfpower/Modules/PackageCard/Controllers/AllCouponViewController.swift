//
//  AllCouponViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import Tabman
import Pageboy
import MJRefresh
class AllCouponViewController:BaseViewController{
    class BottomView:UIView{
        var getCouponBlock:ButtonActionBlock?
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "获取优惠券"
            label.textColor = UIColor(hex:0x333333FF)
            label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "get_coupon")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        lazy var submitButton: UIButton = {
            let button = UIButton(type: .custom)
            button.tintAdjustmentMode = .automatic
            button.setTitle("立即兑换", for: .normal)
            button.setTitle("立即兑换", for: .highlighted)
            button.setTitleColor(UIColor(hex:0xA0A0A0FF), for: .normal)
            button.setTitleColor(UIColor(hex:0xA0A0A0FF).withAlphaComponent(0.5), for: .highlighted)
            button.setImage(UIImage(named: "get_coupon_arrow_right"), for: .normal)
            button.setImage(UIImage(named: "get_coupon_arrow_right"), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13,weight: .semibold)
            button.addTarget(self, action: #selector(getCoupon(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
        @objc func getCoupon(_ sender:UIButton){
            self.getCouponBlock?(sender)
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            submitButton.setImagePosition(type: .imageRight, Space: 7)
            
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            let borderLayer1 = CALayer()
            borderLayer1.frame = frame
            borderLayer1.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
            self.layer.addSublayer(borderLayer1)
            
            // fillCode
            self.backgroundColor = .white
            
            // shadowCode
            self.layer.shadowColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 0.3).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 10
            self.layer.cornerRadius = 10
            self.addSubview(iconImageView)
            self.addSubview(titleLabel)
            self.addSubview(submitButton)
            NSLayoutConstraint.activate([
                iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 22),
                iconImageView.widthAnchor.constraint(equalToConstant: 24),
                iconImageView.heightAnchor.constraint(equalToConstant: 22.5),

                iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor,constant: 6),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 17.5),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16.5),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.submitButton.leadingAnchor,constant: -14),
                submitButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -19),
                submitButton.widthAnchor.constraint(equalToConstant: 80),
                submitButton.heightAnchor.constraint(equalToConstant: 20),



            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    public let content = AllCouponContentViewController()
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "优惠券"
        addChild(content)
        
        self.view.addSubview(content.view)
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        bottomView.getCouponBlock = { button in

            self.presentGetCouponController { text in
                
            } buttonAction: {
                self.presentedViewController?.dismiss(animated: true)
                let scanVC = HFScanViewController()
                scanVC.resultBlock = { result in
                    if let stringScanned = result.strScanned{
                        self.postData(couponReceiveUrl, param: ["code":stringScanned.trimmingCharacters(in: .whitespacesAndNewlines)], isLoading: true) { responseObject in
                            scanVC.navigationController?.popViewController(animated: true)
                            NotificationCenter.default.post(name: .refreshCouponList, object: nil)
                            self.showSuccess(withStatus: "获取优惠券成功")
                        } error: { error in
                            scanVC.navigationController?.popViewController(animated: true)
                            self.showError(withStatus: error.localizedDescription)

                        }
                        

                    }
                }
                self.navigationController?.pushViewController(scanVC, animated: true)
            } sureBlock: { action,text in
                self.postData(couponReceiveUrl, param: ["code":text.trimmingCharacters(in: .whitespacesAndNewlines)], isLoading: true) { responseObject in
                    NotificationCenter.default.post(name: .refreshCouponList, object: nil)
                    self.showSuccess(withStatus: "获取优惠券成功")
                } error: { error in
                    self.showError(withStatus: error.localizedDescription)

                }

               

            }

            
        }
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            content.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor), // 示例：设置固定高度
            
            
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -12)
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
class AllCouponContentViewController: TabmanViewController {
    
    // MARK: - Accessor
    //1可用2已用3已过期0不可用
    let items: [(menu: String, content: UIViewController)] = [(status:1,title:"可用"),(status:2,title:"已用"),(status:3,title:"已过期")].map {
        let title = $0.title
        let vc = AllCouponListViewController()
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
private extension AllCouponContentViewController {
    
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
extension AllCouponContentViewController: PageboyViewControllerDataSource, TMBarDataSource {

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
private extension AllCouponContentViewController {
    
}

// MARK: - Action
@objc private extension AllCouponContentViewController {
    
}

// MARK: - Private
private extension AllCouponContentViewController {
    
}
class AllCouponListViewController:BaseTableViewController<AllCouponListViewCell,HFCouponData>{
    
    
    
    // MARK: - Accessor
    var status = 1 //1可用2已用3已过期0不可用
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
        startObserving()
        loadData()
        
    }
    func startObserving(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshCouponList(_:)), name: .refreshCouponList, object: nil)
        
        
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
        self.getData(couponListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? []).filter { $0.status == self.status }
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
        self.getData(couponListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                let addItems = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? []).filter { $0.status == self.status }
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
        self.getData(couponListUrl, param: ["page":self.pageNum], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? []).filter { $0.status == self.status }
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
    @objc func handleRefreshCouponList(_ notification:Notification){
        loadData()
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Setup
private extension AllCouponListViewController {
    
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
