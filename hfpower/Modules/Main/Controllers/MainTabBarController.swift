//
//  MainTabBarController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class MainTabBarController: UITabBarController,UITabBarControllerDelegate,RentalHandler {
    func rentBike(number: String?) {
        let bikeRentalViewController = BikeRentalViewController()
        bikeRentalViewController.bikeNumber = number ?? ""
        self.navigationController?.pushViewController(bikeRentalViewController, animated: true)
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
    func setupNavbarCustomerService(){
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.text = "核蜂客服"
        self.navigationItem.titleView = titleLabel
        
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
            /*
             let cityChooseVC = CityChooseViewController()
             
             let nav = UINavigationController(rootViewController: cityChooseVC)
             nav.modalPresentationStyle = .fullScreen
             nav.modalTransitionStyle = .coverVertical
             self.present(nav, animated: true)
             */
            let cityHistoryVC = CityHistoryViewController()
            self.navigationController?.pushViewController(cityHistoryVC, animated: true)
        }
        
        headerView.searchView.goToSearchServiceBlock = { textField in
            // Handle search service action
            let cabinetListVC = SearchCabinetListViewController()
            cabinetListVC.hidesBottomBarWhenPushed = true
            let first = self.viewControllers?.first(where: { vc in
                return vc is FirstViewController
            }) as? FirstViewController
            cabinetListVC.coordinate = first?.firstContent.coordinate
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
        startObserving()
    }
    func startObserving(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleCityChanged(_:)), name: .cityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleCityChanged(_:)), name: .relocated, object: nil)
        
    }
    func isiPhoneXScreen() -> Bool {
        
        guard #available(iOS 11.0, *) else {
            
            return false
            
        }
        
        
        if let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom{
            let isX = bottom  > 0
            
            print("是不是--->\(isX)")
            
            return isX
        }else{
            return false
        }
        
        
        
    }
    
    func setupTabbar() {
        // 调整 UITabBarItem 的标题位置偏移
        let offset = UIOffset(horizontal: 0, vertical: 10) // X轴和Y轴的偏移量
        UITabBarItem.appearance().titlePositionAdjustment = offset
        
        // Set background color
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            
            // Critical line of code to handle the tabBar background color
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = self.isiPhoneXScreen() ? UIImage(named: "tab_bar_background")?.resized(toSize:  CGSize(width: UIScreen.main.bounds.size.width, height: 130)):UIImage(named: "tab_bar_background")?.resized(toSize:  CGSize(width: UIScreen.main.bounds.size.width, height: 110))
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
        let first = FirstViewController()
        first.tabBarItem.title = "首页"
        first.tabBarItem.image = UIImage(named: "home")
        first.tabBarItem.selectedImage = UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
        first.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let home = HomeViewController()
        home.tabBarItem.title = "地图"
        home.tabBarItem.image = UIImage(named: "map")
        home.tabBarItem.selectedImage = UIImage(named: "map_selected")?.withRenderingMode(.alwaysOriginal)
        home.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let blank = UIViewController()
        blank.tabBarItem.isEnabled = false
        let customerService = CustomerServiceViewController()
        customerService.tabBarItem.title = "客服"
        customerService.tabBarItem.image = UIImage(named: "customer_service")
        customerService.tabBarItem.selectedImage = UIImage(named: "customer_service_selected")?.withRenderingMode(.alwaysOriginal)
        customerService.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let more = PersonalViewController()
        more.tabBarItem.title = "我的"
        more.tabBarItem.image = UIImage(named: "my")
        more.tabBarItem.selectedImage = UIImage(named: "my_selected")?.withRenderingMode(.alwaysOriginal)
        more.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        self.viewControllers = [first,home, blank, customerService,more]
    }
    
    // MARK: - Setup Center Button
    
    func setupCenterButton() {
        // Create custom button
        
        
        // Button tap event
        
        // Add button to the TabBar
        self.tabBar.addSubview(centerButton)
        
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            self.isiPhoneXScreen() ? centerButton.bottomAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.bottomAnchor, constant: 14):centerButton.bottomAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
        self.postData(memberAgreementUrl, param: [:], isLoading: false) { responseObject in
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
    }
    
    // MARK: - Button Action
    
    @objc func centerButtonTapped(_ sender: UIButton) {
        // Custom button action, e.g., open scan page
        getData(memberUrl, param: [:], isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let member = body["member"] as? [String: Any],
               let isAuth = member["isAuth"] as? Int,isAuth == 1{
                HFScanTool.shared.showScanController(from: self)
            }else{
                self.showAlertController(titleText: "", messageText: "您还未实名认证，请先进行实名认证", okText: "实名认证", okAction: {
                    let realNameAuthVC = RealNameAuthViewController()
                    self.navigationController?.pushViewController(realNameAuthVC, animated: true)
                }, isCancelAlert: true, cancelText: "取消") {
                    
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
        }else if viewController is CustomerServiceViewController{
            self.setupNavbarCustomerService()
        }else if viewController is FirstViewController{
            self.setupNavbarHome()
            
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
        
        
    }
    func rentBattery(number:String?){
        let batteryRentalViewContoller = BatteryRentalViewController()
        batteryRentalViewContoller.batteryNumber = number ?? ""
        self.navigationController?.pushViewController(batteryRentalViewContoller, animated: true)
        
    }
    func batteryReplacement(id:Int?,number:String?){
        self.postData(cabinetScanUrl, param: ["cabinetNumber": number ?? "", "batteryId": id ?? 0], isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let status = body["status"] as? Int{
                if status == 2{
                    if let opNo = body["opNo"] as? String{
                        let batteryReplacementViewController = BatteryReplacementViewController()
                        batteryReplacementViewController.opNo = opNo
                        self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                    }
                }else if status == 1{
                    self.showAlertController(titleText: "提示", messageText: "柜中电池电量低于更换电池是否替换", okAction: {
                        if let opNo = body["opNo"] as? String{
                            self.postData(replaceConfirmUrl, param: ["opNo":opNo], isLoading: true) { responseObject in
                                let batteryReplacementViewController = BatteryReplacementViewController()
                                batteryReplacementViewController.opNo = opNo
                                self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                            } error: { error in
                                self.showError(withStatus: error.localizedDescription)
                            }
                            
                        }
                    }, isCancelAlert: true) {
                        
                    }
                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
        
        
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
    @objc func handleCityChanged(_ notification:Notification){
        if let headerView = self.navigationItem.titleView as? HomeHeaderView{
            headerView.locationChooseView.currentLocationButton.setTitle(CityCodeManager.shared.cityName, for: .normal)
        }
    }
}

// MARK: - Private
private extension MainTabBarController {
    
}
