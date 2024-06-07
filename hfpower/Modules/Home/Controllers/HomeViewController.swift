//
//  HomeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import SVProgressHUD
class HomeViewController: MapViewController{
    
    // MARK: - Accessor
    var accountObservation:NSKeyValueObservation?
    var accountIsAuthObservation:NSKeyValueObservation?
    var cityCodeObservation:NSKeyValueObservation?
    // MARK: - Subviews
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
        loadData()
        accountObservation = AccountManager.shared.observe(\.phoneNum,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newName = change.newValue,let x = newName {
//                print("Name changed to \(x)")
                debugPrint(x)
                self.headerStackView.removeArrangedSubview(self.needLoginView)
                self.needLoginView.removeFromSuperview()
            }else{
                self.headerStackView.insertArrangedSubview(self.needLoginView, at: 0)

            }
        })
        cityCodeObservation = CityCodeManager.shared.observe(\.cityCode,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newCode = change.newValue,let x = newCode {
            debugPrint(x)
            }
        })
        cityCodeObservation = CityCodeManager.shared.observe(\.cityName,options: [.old,.new,.initial], changeHandler: { tokenManager, change in
            if let newName = change.newValue,let x = newName {
                self.locationChooseView.currentLocationButton.setTitle(x, for: .normal)
                self.moveMap()
            }
        })
       
    }
    func loadData(){
        NetworkService<MemberAPI>().request(.member, model: MemberResponse.self) { result in
            switch result {
            case.success(let response):
                
                AccountManager.shared.isAuth = NSNumber(integerLiteral: response?.member?.isAuth ?? -1)
                
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                
            }
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
//        headerStackView.addArrangedSubview(needLoginView)
//        headerStackView.addArrangedSubview(needAuthView)
//        let creditDepositFreeView = CreditDepositFreeView()
//        headerStackView.addArrangedSubview(creditDepositFreeView)
//        let expirationView = ExpirationView()
//        headerStackView.addArrangedSubview(expirationView)
//        let batteryOfflineView = BatteryOfflineView()
//        headerStackView.addArrangedSubview(batteryOfflineView)
        headerStackView.addArrangedSubview(packageCardView)

        let mapBatteryView = MapBatteryView()
        footerStackView.addArrangedSubview(mapBatteryView)
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
