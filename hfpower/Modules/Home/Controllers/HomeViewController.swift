//
//  HomeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import CoreLocation
import MapKit
class HomeViewController: MapViewController{
    
    // MARK: - Accessor
    var homeObservation:NSKeyValueObservation?
    var accountObservation:NSKeyValueObservation?
    var accountIsAuthObservation:NSKeyValueObservation?
    var cityCodeObservation:NSKeyValueObservation?
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
        homeObservation = MainManager.shared.observe(\.batteryDetail,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let temp = change.newValue,let batteryDetail = temp {
                self.batteryView.batteryView.batteryLevel = (batteryDetail.mcuCapacityPercent?.doubleValue ?? 0.00)/100.0
                self.footerStackView.insertArrangedSubview(self.batteryView, at: 0)

            }else{
                self.footerStackView.removeArrangedSubview(self.batteryView)
                self.batteryView.removeFromSuperview()

            }
        })
        accountObservation = AccountManager.shared.observe(\.phoneNum,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newName = change.newValue,let _ = newName {
//                print("Name changed to \(x)")
                self.headerStackView.removeArrangedSubview(self.needLoginView)
                self.needLoginView.removeFromSuperview()
                self.fetchData()
            }else{
                self.headerStackView.insertArrangedSubview(self.needLoginView, at: 0)
                let loginVC = LoginViewController()
                
                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .coverVertical
                self.present(nav, animated: true)
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
            }else{
                self.headerStackView.insertArrangedSubview(self.needAuthView, at: 0)
            }
        })
        
        cityCodeObservation = CityCodeManager.shared.observe(\.cityName,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newName = change.newValue,let x = newName {
                self.locationChooseView.currentLocationButton.setTitle(x, for: .normal)
                self.moveMap()
            }
        })
       
    }
    func fetchData(){
        // 创建一个 DispatchGroup
        let dispatchGroup = DispatchGroup()

        // 创建一个并发队列
        let concurrentQueue = DispatchQueue.global(qos: .background)
        dispatchGroup.enter()
        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            NetworkService<MemberAPI>().request(.member, model: MemberResponse.self) { result in
                switch result {
                case.success(let response):
                    
                    AccountManager.shared.isAuth = NSNumber(integerLiteral: response?.member?.isAuth ?? -1)
                    dispatchGroup.leave()

                case .failure(let error):
                    self.showError(withStatus: error.localizedDescription)
                    dispatchGroup.leave()

                }
            }
        }))
        dispatchGroup.enter()

        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            NetworkService<MemberAPI>().request(.activityList, model: ActivityListResponse<ActivityResponse>.self) { result in
                switch result {
                case .success(let response):
                    debugPrint(response)
                    dispatchGroup.leave()

                case .failure(let error):
                    debugPrint(error)
                    dispatchGroup.leave()

                }
            }
        }))
        // 启动第一个异步任务
        dispatchGroup.enter()

        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            NetworkService<BusinessAPI>().request(.batteryList, model: DataListResponse<BatterySummary>.self) { result in
                switch result {
                case.success(let response):

                    MainManager.shared.batteryDetail = BatteryDetail.fromStruct(response?.pageResult?.dataList?.first)
                    dispatchGroup.leave()

                case .failure(let error):
                    debugPrint(error)
                    dispatchGroup.leave()

                    
                }
            }
        }))
      

        // 启动第二个异步任务
        dispatchGroup.enter()

        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            // 模拟耗时任务
            NetworkService<BusinessAPI>().request(.locomotiveList, model: DataListResponse<LocomotiveSummary>.self) { result in
                switch result {
                case.success(let response):

                    MainManager.shared.bikeDetail = BikeDetail.fromStruct(response?.pageResult?.dataList?.first)
                    dispatchGroup.leave()

                case .failure(let error):
                    dispatchGroup.leave()


                    
                }
            }
        }))
     

        // 启动第三个异步任务
        dispatchGroup.enter()
        concurrentQueue.async(group: dispatchGroup, execute: DispatchWorkItem(block: {
            // 模拟耗时任务
            NetworkService<BatteryDepositAPI>().request(.batteryTempOrderInfo, model: BatteryDepositResponse.self) { result in
                switch result {
                case.success(let response):

                    MainManager.shared.batteryDeposit = BatteryDepositInfo.fromStruct(response)
                    dispatchGroup.leave()

                case .failure(let error):
                    debugPrint(error)
                    dispatchGroup.leave()


                }
            }
        }))
        
        // 在所有任务完成后执行
       
        dispatchGroup.notify(queue: DispatchQueue.main) {
            var type:NSNumber = 0
            if MainManager.shared.batteryDeposit?.id != nil{
                type = 2
            }else{
                if MainManager.shared.batteryDetail?.id != nil{
                    type = 1
                }else{
                    type = 0
                }
            }
            MainManager.shared.type = type
            self.loadCabinetListData(self.mapView.centerCoordinate)
            
        }
    }
   
    
  
    deinit {
        accountObservation?.invalidate()
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
        
        
        self.view.addSubview(headerStackView)
        self.view.addSubview(footerStackView)
        
        needLoginView.loginAction = { (sender) -> Void in
            let loginVC = LoginViewController()
            
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            self.present(nav, animated: true)
        }
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
        headerStackView.addArrangedSubview(packageCardView)

       
        footerStackView.addArrangedSubview(inviteView)
        
        
        let listView = MapFeatureView(.list) { sender, mapFeatureType in
            
        }
        footerStackView.addArrangedSubview(listView)
        let locateView = MapFeatureView(.locate) { sender, mapFeatureType in
            self.manager.startUpdatingLocation()
        }
        footerStackView.addArrangedSubview(locateView)
        let refreshView = MapFeatureView(.refresh) { sender, mapFeatureType in
            
        }
        footerStackView.addArrangedSubview(refreshView)
        let filterView = MapFeatureView(.filter) { sender, mapFeatureType in
            
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
    
}

// MARK: - Private
private extension HomeViewController {
    
}
