//
//  HomeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import CoreLocation
import MapKit
class HomeViewController: UIViewController{
    
    // MARK: - Accessor
    var homeObservation:NSKeyValueObservation?
    var accountIsAuthObservation:NSKeyValueObservation?
    var cityCodeObservation:NSKeyValueObservation?
    let mapViewController = MapViewController()
    // MARK: - Subviews
    lazy var batteryView:MapBatteryView = {
        let view = MapBatteryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var inviteView:MapInviteView = {
        let view = MapInviteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var packageCardView:MapPackageCardView = {
        let view = MapPackageCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var headerStackView:HFStackView = {
        let stackView = HFStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var headerStackBatteryView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var footerStackView:HFStackView = {
        let stackView = HFStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var locationChooseView:LocationChooseView = {
        let view = LocationChooseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var searchView:SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var needLoginView:NeedLoginView = {
        let view = NeedLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var needAuthView:NeedAuthView = {
        let view = NeedAuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
        startObserving()
        if let _ = AccountManager.shared.phoneNum,self.isViewLoaded{
            self.fetchAuthData()
            self.fetchActivities()
        }
       
        homeObservation = MainManager.shared.observe(\.batteryDetail,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let temp = change.newValue,let batteryDetail = temp {
                self.batteryView.batteryView.batteryLevel = (batteryDetail.mcuCapacityPercent?.doubleValue ?? 0.00)/100.0
                self.headerStackBatteryView.addSubview(self.batteryView)
                
            }else{
                self.headerStackBatteryView.removeArrangedSubview(self.batteryView)
                self.batteryView.removeFromSuperview()
                
            }
        })
        
        accountIsAuthObservation = AccountManager.shared.observe(\.isAuth,options: [.old,.new,.initial], changeHandler: { accountManager, change in
            if let tempAuth = change.newValue,let isAuth = tempAuth {
                if  isAuth == 1 {
                    self.headerStackView.removeArrangedSubview(self.needAuthView)
                    self.needAuthView.removeFromSuperview()
                }else{
                    self.headerStackView.insertArrangedSubview(self.needAuthView, at: 0)
                    
                }
            }
        })
        
        cityCodeObservation = CityCodeManager.shared.observe(\.cityName,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newName = change.newValue,let x = newName {
                self.locationChooseView.currentLocationButton.setTitle(x, for: .normal)
                self.mapViewController.moveMap()
            }
        })
        
    }
    func startObserving(){
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthState(_:)), name: .userAuthenticated, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    func fetchActivities(){
        NetworkService<MemberAPI,ActivityListResponse<ActivityResponse>>().request(.activityList) { result in
            switch result {
            case .success(let response):
                ActivityListManager.shared.activityList = response?.inviteList
            case .failure(let error):
                debugPrint(error)
                
            }
        }
    }
    func fetchAuthData(){
        NetworkService<MemberAPI,MemberResponse>().request(.member) { result in
            switch result {
            case.success(let response):
                
                AccountManager.shared.isAuth = NSNumber(integerLiteral: response?.member?.isAuth ?? -1)
                if  AccountManager.shared.isAuth == 1{
                    NotificationCenter.default.post(name: .userAuthenticated, object: nil)
                    
                }
                
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                
            }
        }
    }
    func fetchBikeData(){
        
        
        NetworkService<BusinessAPI,DataListResponse<LocomotiveSummary>>().request(.locomotiveList) { result in
            switch result {
            case.success(let response):
                
                MainManager.shared.bikeDetail = BikeDetail.fromStruct(response?.pageResult?.dataList?.first)
                
            case .failure(let error):
                debugPrint(error)
                
                
            }
        }
    }
    func fetchData(){
        // 创建一个 DispatchGroup
        let dispatchGroup = DispatchGroup()
        
        // 创建一个并发队列
        let concurrentQueue = DispatchQueue(label: "org.alamofire.session.home")
        
        
        // 启动第一个异步任务
        dispatchGroup.enter()
        
        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            NetworkService<BusinessAPI,DataListResponse<BatterySummary>>().request(.batteryList) { result in
                dispatchGroup.leave()
                
                switch result {
                case.success(let response):
                    
                    MainManager.shared.batteryDetail = BatteryDetail.fromStruct(response?.pageResult?.dataList?.first)
                    
                case .failure(let error):
                    debugPrint(error)
                    
                    
                }
            }
        }))
        
        
        
        
        
        // 启动第三个异步任务
        dispatchGroup.enter()
        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            // 模拟耗时任务
            NetworkService<BatteryDepositAPI,BatteryDepositResponse>().request(.batteryTempOrderInfo) { result in
                dispatchGroup.leave()
                
                switch result {
                case.success(let response):
                    
                    MainManager.shared.batteryDeposit = BatteryDepositInfo.fromStruct(response)
                    
                case .failure(let error):
                    debugPrint(error)
                    
                    
                }
            }
        }))
        
        // 在所有任务完成后执行
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            MainManager.shared.refreshType()
            
        }
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        accountIsAuthObservation?.invalidate()
        cityCodeObservation?.invalidate()
    }
    
    
}

// MARK: - Setup
private extension HomeViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        // 设置地图的初始位置和显示范围
        
        self.addChild(mapViewController)
        self.view.addSubview(mapViewController.view)
        mapViewController.view.frame = self.view.bounds
        
        mapViewController.didMove(toParent: self)
        self.view.addSubview(headerStackView)
        self.view.addSubview(footerStackView)
        self.batteryView.goToBatteryDetailBlock = { sender in
            let batteryDetailVC = BatteryDetailViewController()
            self.navigationController?.pushViewController(batteryDetailVC, animated: true)
        }
        self.view.addSubview(headerStackBatteryView)
        
       
        self.view.addSubview(locationChooseView)
        locationChooseView.chooseCityAction = { (sender) -> Void in
            let cityChooseVC = CityChooseViewController()
            
            let nav = UINavigationController(rootViewController: cityChooseVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            self.present(nav, animated: true)
        }
        self.view.addSubview(searchView)
        searchView.goToSearchServiceBlock = { textField in
            let cabinetListVC = SearchCabinetListViewController()
            cabinetListVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(cabinetListVC, animated: true)
        }
        searchView.goToNotificationBlock = { (sender) -> Void in
            let notificationVC = NotificationViewController()
            notificationVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
        searchView.goToCustomerServiceBlock = { (sender) -> Void in
            let customerVC = CustomerServiceViewController()
            customerVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(customerVC, animated: true)
        }
        needAuthView.authAction = { sender in
            let realNameAuthVC = RealNameAuthViewController()
            
            let nav = UINavigationController(rootViewController: realNameAuthVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            self.present(nav, animated: true)
        }
        //        headerStackView.addArrangedSubview(needLoginView)
        //        headerStackView.addArrangedSubview(needAuthView)
        //        let creditDepositFreeView = CreditDepositFreeView()
        //        headerStackView.addArrangedSubview(creditDepositFreeView)
        //        let expirationView = ExpirationView()
        //        headerStackView.addArrangedSubview(expirationView)
        //        let batteryOfflineView = BatteryOfflineView()
        //        headerStackView.addArrangedSubview(batteryOfflineView)
        packageCardView.goToBuyPackageCardAction = { sender in
            let vc=PackageCardChooseServiceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        headerStackView.addArrangedSubview(packageCardView)
        
        footerStackView.addArrangedSubview(inviteView)
        
        
        let listView = MapFeatureView(.list) { sender, mapFeatureType in
            let cabinetListViewController = CabinetListViewController()
            self.navigationController?.pushViewController(cabinetListViewController, animated: true)
        }
        footerStackView.addArrangedSubview(listView)
        let locateView = MapFeatureView(.locate) { sender, mapFeatureType in
            self.mapViewController.mapView.userTrackingMode = .followWithHeading
            
        }
        footerStackView.addArrangedSubview(locateView)
        let refreshView = MapFeatureView(.refresh) { sender, mapFeatureType in
            self.mapViewController.loadCabinetListData()
        }
        footerStackView.addArrangedSubview(refreshView)
        let filterView = MapFeatureView(.filter) { sender, mapFeatureType in
            let contentVC = CabinetFilterViewController()
            contentVC.closeAction = { sender in
                self.mapViewController.hideFloatingPanel(contentVC)
            }
            self.mapViewController.showFloatingPanel(contentVC)
        }
        footerStackView.addArrangedSubview(filterView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            locationChooseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            locationChooseView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            locationChooseView.heightAnchor.constraint(equalToConstant: 44),
            
            searchView.leadingAnchor.constraint(equalTo: locationChooseView.trailingAnchor,constant: 12),
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            searchView.heightAnchor.constraint(equalToConstant: 44),
            searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            headerStackView.topAnchor.constraint(equalTo: self.locationChooseView.bottomAnchor,constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            headerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            headerStackBatteryView.topAnchor.constraint(equalTo: self.headerStackView.bottomAnchor,constant: 10),
            headerStackBatteryView.widthAnchor.constraint(equalToConstant: 52),
            headerStackBatteryView.heightAnchor.constraint(equalToConstant: 70),
            headerStackBatteryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            footerStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -26),
            footerStackView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14-38-14),
            footerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            
            
            
            
        ])
        
    }
}

// MARK: - Public
extension HomeViewController {
    
}

// MARK: - Request
private extension HomeViewController {
    
}

// MARK: - Action
@objc private extension HomeViewController {
    @objc func needLogin(_ sender:UIButton){
        
    }
    @objc func handleLoginState(_ notification:Notification){
        if notification.name == .userLoggedOut{
            TokenManager.shared.clearTokens()
            AccountManager.shared.clearAccount()
            MainManager.shared.resetAll()
        }else if notification.name == .userLoggedIn{
            self.mapViewController.locationManager.startUpdatingLocation()
            
            if let _ = AccountManager.shared.phoneNum,self.isViewLoaded{
                self.fetchAuthData()
                self.fetchActivities()
            }
           
        }
        
        
    }
    @objc func handleAuthState(_ notification:Notification){
        if let isAuth = AccountManager.shared.isAuth,isAuth == 1,self.isViewLoaded{
            self.fetchData()
            self.fetchBikeData()
        }
    }
}

// MARK: - Private
private extension HomeViewController {
    
}
