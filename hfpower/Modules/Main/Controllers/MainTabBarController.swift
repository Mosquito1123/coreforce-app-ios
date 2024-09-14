//
//  MainTabBarController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class MainTabBarController: UITabBarController,UITabBarControllerDelegate,BatteryRentalViewControllerDelegate,BatteryReplacementViewControllerDelegate, BikeRentalViewControllerDelegate {
    func rentBike(number: String?) {
        
    }
    
    
    // MARK: - Accessor
    lazy var centerButton: MainScanButton = {
        let button = MainScanButton()
        button.addTarget(self, action: #selector(centerButtonTapped(_:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Subviews
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshBatteryDataList {
            
        } bikeDataBlock: {
            
        } batteryDepositDataBlock: {
            
        } complete: { data in
            self.updateCenterButton()
        }
        
    }
    // MARK: - Lifecycle
    func updateCenterButton() {
        let orderInfo =  HFKeyedArchiverTool.batteryDepositOrderInfo()
        let batteryArray = HFKeyedArchiverTool.batteryDataList()
        if orderInfo.id != nil{
            self.centerButton.type = .battery_release
            
        }else{
            if batteryArray.count > 0{
                self.centerButton.type = .battery_change
                
            }else{
                self.centerButton.type = .battery_rent
                
            }
            
        }
        
    }
    
    func setupNavbarMore() {
        self.navigationItem.titleView = nil
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
            
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        }
    }
    
    func setupNavbarHome() {
        let headerView = HomeHeaderView()
        self.navigationItem.titleView = headerView
        
        headerView.locationChooseView.chooseCityAction = { sender in
            // Handle city choose action
            let cityChooseVC = CityChooseViewController()
            
            let nav = UINavigationController(rootViewController: cityChooseVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            self.present(nav, animated: true)
        }
        
        headerView.searchView.goToSearchServiceBlock = { textField in
            // Handle search service action
            let cabinetListVC = SearchCabinetListViewController()
            cabinetListVC.hidesBottomBarWhenPushed = true
            cabinetListVC.coordinate = (self.viewControllers?.first as? HomeViewController)?.mapView.centerCoordinate
            self.navigationController?.pushViewController(cabinetListVC, animated: true)
        }
        
        headerView.searchView.goToNotificationBlock = { sender in
            // Handle notification action
            let messageListVC = MessageListViewController()
            self.navigationController?.pushViewController(messageListVC, animated: true)
        }
        
        headerView.searchView.goToCustomerServiceBlock = { sender in
            // Handle customer service action
            let customerVC = CustomerServiceViewController()
            customerVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(customerVC, animated: true)
        }
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
            
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    
        
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        setupTabbar()
        setupCenterButton()
    }
    func setupTabbar() {
        // Set background color
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            
            // Critical line of code to handle the tabBar background color
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = UIImage(named: "tab_bar_background")?.resized(toSize:  CGSize(width: UIScreen.main.bounds.size.width, height: 130))
            appearance.shadowImage = UIColor.clear.toImage()
            appearance.backgroundImageContentMode = .bottom
            self.tabBar.standardAppearance = appearance
            
            // Ensures the background color doesn't change when switching items or scrolling
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
            }
        } else {
            // Fallback for earlier iOS versions
            self.tabBar.isTranslucent = true
            self.tabBar.shadowImage = UIColor.clear.toImage()
            self.tabBar.backgroundImage = UIColor.clear.toImage()
        }
        
        // Create view controllers for the tab bar
        let home = HomeViewController()
        home.tabBarItem.title = "首页"
        home.tabBarItem.image = UIImage(named: "map")
        
        let blank = UIViewController()
        blank.tabBarItem.isEnabled = false
        
        let more = PersonalViewController()
        more.tabBarItem.title = "我的"
        more.tabBarItem.image = UIImage(named: "my")
        
        self.viewControllers = [home, blank, more]
    }
    
    // MARK: - Setup Center Button
    
    func setupCenterButton() {
        // Create custom button
        
        
        // Button tap event
        
        // Add button to the TabBar
        self.tabBar.addSubview(centerButton)
        
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            centerButton.bottomAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.bottomAnchor, constant: 14)
        ])
    }
    
    // MARK: - Button Action
    
    @objc func centerButtonTapped(_ sender: UIButton) {
        // Custom button action, e.g., open scan page
        getData(memberUrl, param: [:], isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let member = body["member"] as? [String: Any],
               let isAuth = member["isAuth"] as? Int{
                if isAuth == 1{
                    HFScanTool.shared.showScanController(from: self)
                    
                }else{
                    self.showWindowInfo(withStatus: "请您先完成实名认证")
                    let realNameAuthVC = RealNameAuthViewController()
                    self.navigationController?.pushViewController(realNameAuthVC, animated: true)
                }
                
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HomeViewController{
            self.setupNavbarHome()
        }else if viewController is PersonalViewController{
            self.setupNavbarMore()
        }
    }
    override var selectedIndex: Int{
        didSet{
            if selectedIndex == 0{
                self.setupNavbarHome()
            }else if selectedIndex == 2{
                self.setupNavbarMore()
            }
        }
    }
    func cabinetRentBattery(number: String?) {
        self.postData(cabinetScanRentUrl, param: ["cabinetNumber":number ?? ""], isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let list = body["list"]{
                if let typeList = HFBatteryRentalTypeInfo.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryRentalTypeInfo]{
                  let batteryRentalChooseTypeViewController = BatteryRentalChooseTypeViewController()
                    batteryRentalChooseTypeViewController.items = typeList
                    self.navigationController?.pushViewController(batteryRentalChooseTypeViewController, animated: true)
                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

        /*NetworkService<BusinessAPI,CabinetDetailResponse>().request(.cabinet(id: nil, number: number)) { result in
            switch result {
            case .success(let response):
                if  let payingOrderId = response?.payingOrderId{
                    self.showAlertController(titleText: "温馨提示", messageText: "您有订单尚未完成支付，取消订单将会返还已使用优惠券到您账户，是否取消？") {
                        self.presentedViewController?.dismiss(animated: true)
                        let orderDetailVC = OrderDetailViewController()
                        orderDetailVC.element = OrderList(id: payingOrderId)
                        self.navigationController?.pushViewController(orderDetailVC, animated: true)
                    } cancelAction: {
                        /*NetworkService<BusinessAPI,BlankResponse>().request(.orderCancel(orderId: payingOrderId)) { result in
                            switch result {
                            case .success:
                                self.showSuccess(withStatus: "取消成功")
                            case .failure(let failure):
                                self.showError(withStatus: failure.localizedDescription)
                            }
                        }             */

                    }
                }else{
                    self.showAlertController(titleText: "温馨提示", messageText: "您确定要电池柜租电？") {
                        
                    } cancelAction: {
                        
                    }
                }
                
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
            }
        }             */
    }
    func rentBattery(number:String?){
        let batteryRentalViewContoller = BatteryRentalViewController()
//        batteryRentalViewContoller.batteryNumber = number ?? ""
        self.navigationController?.pushViewController(batteryRentalViewContoller, animated: true)

    }
    func batteryReplacement(id:Int?,number:String?){
        /*NetworkService<BusinessAPI,CabinetScanResponse>().request(.cabinetScan(cabinetNumber: number, batteryId: id)) { result in
            switch result {
            case .success(let response):
                
                if response?.status == 1{
                    self.showAlertController(titleText: "提示", messageText: "柜中电池电量低于更换电池是否替换") {
                        let batteryReplacementViewController = BatteryReplacementViewController()
                        batteryReplacementViewController.opNo = response?.opNo ?? ""
                        self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                    }cancelAction: {
                        
                    }
                }else if response?.status == 2{
                    let batteryReplacementViewController = BatteryReplacementViewController()
                    batteryReplacementViewController.opNo = response?.opNo ?? ""
                    self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                }
            case .failure(let failure):
                self.showError(withStatus: failure.localizedDescription)
                
            }
        }             */

    }
    func addRoundedCorners() {
        
        tabBar.layer.borderWidth = 0.5 // Adjust the border width as needed
        tabBar.layer.borderColor = UIColor.clear.cgColor // Set border color to clear
        tabBar.shadowImage = UIColor.clear.toImage()
        tabBar.backgroundImage = UIColor.clear.toImage()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(origin: tabBar.bounds.origin, size: CGSize(width: tabBar.bounds.size.width, height: tabBar.bounds.size.height + 40)),
                                       byRoundingCorners: [.topLeft, .topRight],
                                       cornerRadii: CGSize(width: 8, height: 8)).cgPath
        let barLeftArc = CAShapeLayer()
        barLeftArc.contents = UIImage(named: "bar_left_arc")?.cgImage
        barLeftArc.frame = CGRect(x: tabBar.bounds.midX - 49 - 64 + 30, y: tabBar.bounds.minY - 24 + 12, width: 64, height: 24)
        let barRightArc = CAShapeLayer()
        barRightArc.contents = UIImage(named: "bar_right_arc")?.cgImage
        barRightArc.frame = CGRect(x: tabBar.bounds.midX + 49 - 30, y: tabBar.bounds.minY - 24 + 12, width: 64, height: 24)
        shapeLayer.addSublayer(barLeftArc)
        shapeLayer.addSublayer(barRightArc)
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - Setup
private extension MainTabBarController {
    
    private func setupNavbar() {
        //        addRoundedCorners()
        
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension MainTabBarController {
    
    
}

// MARK: - Request
private extension MainTabBarController {
    
}

// MARK: - Action
@objc private extension MainTabBarController {
    
}

// MARK: - Private
private extension MainTabBarController {
    
}
