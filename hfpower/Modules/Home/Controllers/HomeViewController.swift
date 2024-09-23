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
    // MARK: - Subviews
    lazy var batteryView:MapBatteryView = {
        let view = MapBatteryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var inviteView:MapInviteView = {
        let view = MapInviteView()
        view.isHidden = true
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
    lazy var batteryOfflineView: BatteryOfflineView = {
        let view = BatteryOfflineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var needLoginView:NeedLoginView = {
        let view = NeedLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var authStatusView:AuthStatusView = {
        let view = AuthStatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        startObserving()
        loadActivities()
        
        
    }
    func eventViewController(_ modelList:[HFActivityListModel]){
        
    }
    func loadActivities() {
        // Activity popup
        weak var weakSelf = self
        
        getData(activityListUrl, param: [:], isLoading: false, success: { responseObject in
            guard let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                  let inviteList = body["inviteList"] as? [[String: Any]] else {
                self.inviteView.isHidden = true
                return
            }
            
            let modelList = HFActivityListModel.mj_objectArray(withKeyValuesArray: inviteList) as? [HFActivityListModel] ?? []
            
            if inviteList.count > 0 {
                let now = Date()
                let lastVisitDate = UserDefaults.lastDailyVisitDate()
                
                self.inviteView.inviteButton.setBackgroundImage(UIImage(named: "invite_button"), for: .normal)
                self.inviteView.inviteButton.setBackgroundImage(UIImage(named: "invite_button"), for: .selected)
                
                if let vDate = lastVisitDate,Calendar.current.isDate(now, inSameDayAs: vDate) {
                    // Show "first visit of the day" popup
                    self.eventViewController(modelList)
                    UserDefaults.setLastDailyVisit(now)
                    UserDefaults.setHiddenFloatButton(true)
                    
                } else {
                    let predicate0 = NSPredicate(format: "type == %@", NSNumber(value: 0))
                    let filteredArray0 = modelList.filter { predicate0.evaluate(with: $0) }
                    
                    if filteredArray0.first != nil {
                        UserDefaults.setHiddenFloatButton(false)
                    } else {
                        UserDefaults.setHiddenFloatButton(true)
                    }
                    
                }
                
                self.inviteView.isHidden = UserDefaults.hiddenFloatButton()
                self.inviteView.goToInviteAction = { sender in
                    let predicate0 = NSPredicate(format: "type == %@", NSNumber(value: 0))
                    let filteredArray0 = modelList.filter { predicate0.evaluate(with: $0) }
                    
                    if let firstObject = filteredArray0.first, weakSelf?.checkUrlWithString(firstObject.url ) == true {
                        let inviteVC = InviteViewController()
                        inviteVC.isInvite = true
                        inviteVC.activityModel = firstObject
                        weakSelf?.navigationController?.pushViewController(inviteVC, animated: false)
                    }
                }
            }
        }, error: { error in
            // Handle error
        })
    }

    func checkUrlWithString(_ url: String) -> Bool {
        if url.count < 1 {
            return false
        }
        
        var updatedUrl = url
        if url.count > 4 && url.prefix(4) == "www." {
            updatedUrl = "http://\(url)"
        }
        
        // Regex pattern for URL matching
        let urlRegex = "^[a-z][a-z0-9+.-]*:\\/\\/([a-zA-Z0-9\\-\\.]+\\.)+[a-zA-Z]{2,3}(\\/[^#?]*)?(\\?[^\\s#]*)?(#[^\\s]*)?$"
        
        do {
            let regex = try NSRegularExpression(pattern: urlRegex, options: [])
            let match = regex.firstMatch(in: updatedUrl, options: [], range: NSRange(location: 0, length: updatedUrl.count))
            return match != nil
        } catch {
            print("Error creating regular expression: \(error)")
            return false
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshBatteryDataList {
            
        } bikeDataBlock: {
            
        } batteryDepositDataBlock: {
            
        } complete: { data in
            self.refreshViews()
        }

    }
    func refreshViews() {
        let batteryDataArray = HFKeyedArchiverTool.batteryDataList()
        let bikeList = HFKeyedArchiverTool.bikeDetailList()
        let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()
        // Clear arrangedSubviews and remove each subview
        for subview in self.headerStackView.arrangedSubviews {
            self.headerStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for subview in self.headerStackBatteryView.arrangedSubviews {
            self.headerStackBatteryView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        getData( memberUrl, param: [:], isLoading: false, success: { responseObject in
            guard let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                  let member = body["member"] as? [String: Any],
                  let isAuth = member["isAuth"] as? Int else {
                self.headerStackView.addArrangedSubview(self.authStatusView)

                return
            }
            
            if isAuth == 1 || isAuth == 2 {
                self.headerStackView.addArrangedSubview(self.packageCardView)
                
                if  orderInfo.id != nil {
//                    if self.isTodayOrTomorrowDateString(orderInfo.endDate) {
//                        // Handle order end date conditions
//                    } else {
//                        // Handle battery storage day conditions
//                    }
                } else if batteryDataArray.count > 0 {
                    self.headerStackBatteryView.addArrangedSubview(self.batteryView)
                    self.batteryView.batteryView.batteryLevel = CGFloat(batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0) / 100
                    
                    if !(batteryDataArray.first?.onLine.boolValue ?? true) {
                        self.headerStackView.addArrangedSubview(self.batteryOfflineView)
                    } else if self.isWinter() {
                        if batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0 <= 30 {
                            // Handle battery low in winter
                        }
                    } else if batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0 <= 20 {
                        // Handle battery low
                    }
                }
                
                if  bikeList.count > 0 {
                    // Handle bike list
                }
            } else {
                self.headerStackView.addArrangedSubview(self.authStatusView)
            }
        }, error: { error in
            // Handle error scenario
            if orderInfo.id != nil {
//                if self.isTodayOrTomorrowDateString(orderInfo.endDate) {
//                    // Handle order end date conditions
//                } else {
//                    // Handle battery storage day conditions
//                }
            } else if batteryDataArray.count > 0 {
                self.headerStackBatteryView.addArrangedSubview(self.batteryView)
                self.batteryView.batteryView.batteryLevel = CGFloat(batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0) / 100
                
                if !(batteryDataArray.first?.onLine.boolValue ?? true) {
                    self.headerStackView.addArrangedSubview(self.batteryOfflineView)
                } else if self.isWinter() {
                    if batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0 <= 30 {
                        // Handle battery low in winter
                    }
                } else if batteryDataArray.first?.mcuCapacityPercent?.doubleValue ?? 0 <= 20 {
                    // Handle battery low
                }
            }
        })
    }

    func isWinter() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)
        
        return [11, 12, 1, 2, 3].contains(month)
    }

    func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .refreshDeviceNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowNotification(_:)), name: .floatButtonShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleCityChanged(_:)), name: .cityChanged, object: nil)

    }

    @objc func handleShowNotification(_ notification: Notification) {
        UserDefaults.setHiddenFloatButton(false)
        self.inviteView.isHidden = false
        
        self.inviteView.goToInviteAction = { sender in
            guard let item = notification.object as? HFActivityListModel, !item.url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return
            }
            
            let inviteVC = InviteViewController()
            inviteVC.isInvite = true
            inviteVC.activityModel = item
            self.navigationController?.pushViewController(inviteVC, animated: false)
        }
    }

    @objc func handleNotification(_ notification: Notification) {
        refreshBatteryDataList({
        }, bikeDataBlock: {
        }, batteryDepositDataBlock: {
        }, complete: { result in
            self.refreshViews()
        })
    }

  
   
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

// MARK: - Setup
private extension HomeViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        // 设置地图的初始位置和显示范围
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(headerStackView)
        self.view.addSubview(footerStackView)
        self.batteryView.goToBatteryDetailBlock = { sender in
            let batteryDetailVC = BatteryDetailViewController()
            self.navigationController?.pushViewController(batteryDetailVC, animated: true)
        }
        self.view.addSubview(headerStackBatteryView)
        
        
        
       
        authStatusView.buttonTapHandler = {

            self.getData(memberUrl, param: [:], isLoading: false, success: { (responseObject) in
                if let body =  (responseObject as? [String: Any])?["body"] as? [String: Any],
                   let member = body["member"] as? [String: Any],
                   let isAuth = member["isAuth"] as? Int {
                    if isAuth == 2 {
                        self.showInfo(withStatus:"该账户正在认证，请耐心等待认证结果")
                    } else {
                        let realNameAuthVC = RealNameAuthViewController()
                        self.navigationController?.pushViewController(realNameAuthVC, animated: true)
                    }
                }else{
                    let realNameAuthVC = RealNameAuthViewController()
                    self.navigationController?.pushViewController(realNameAuthVC, animated: true)
                }
            }, error: { (error) in
                self.showToastMessage(error.localizedDescription)
            })

            
          
        }
       
        packageCardView.goToBuyPackageCardAction = { sender in
//            let vc=PackageCardChooseServiceViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
            let chooseBatteryTypeViewController =  ChooseBatteryTypeViewController()
            self.navigationController?.pushViewController(chooseBatteryTypeViewController, animated: true)
        }
        headerStackView.addArrangedSubview(packageCardView)
        
        footerStackView.addArrangedSubview(inviteView)
        
        
        let listView = MapFeatureView(.list) { sender, mapFeatureType in
            let cabinetListViewController = CabinetListViewController()
            cabinetListViewController.coordinate = self.mapView.centerCoordinate
            self.navigationController?.pushViewController(cabinetListViewController, animated: true)
        }
        footerStackView.addArrangedSubview(listView)
        let locateView = MapFeatureView(.locate) { sender, mapFeatureType in
            self.locationManager.startUpdatingLocation()
            self.mapView.userTrackingMode = .followWithHeading
            
        }
        footerStackView.addArrangedSubview(locateView)
        let refreshView = MapFeatureView(.refresh) { sender, mapFeatureType in
            self.cabinetList()
        }
        footerStackView.addArrangedSubview(refreshView)
        let filterView = MapFeatureView(.filter) { sender, mapFeatureType in
            let contentVC = CabinetFilterViewController()
            contentVC.typeItem = self.typeItem
            contentVC.powerItem = self.powerItem
            contentVC.closeAction = { sender in
                self.hideFloatingPanel(contentVC)
            }
            contentVC.sureAction = { sender,typeItem,powerItem in
                self.typeItem = typeItem
                self.powerItem = powerItem
                self.updateCabinetList(coordinate:self.mapView.centerCoordinate,largeTypeId: self.typeItem?.content,powerLevel: self.powerItem?.content)
                self.hideFloatingPanel(contentVC)
            }
            self.showFloatingPanel(contentVC)
        }
        footerStackView.addArrangedSubview(filterView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
           
            
            headerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            headerStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            headerStackBatteryView.topAnchor.constraint(equalTo: self.headerStackView.bottomAnchor,constant: 10),
      
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
    @objc func handleCityChanged(_ notification:Notification){
        self.updateCabinetList(coordinate:nil,largeTypeId: self.typeItem?.content,powerLevel: self.powerItem?.content)
        self.moveMap()
    }
    @objc func needLogin(_ sender:UIButton){
        
    }
    @objc func handleLoginState(_ notification:Notification){
        if notification.name == .userLoggedOut{
            TokenManager.shared.clearTokens()
            AccountManager.shared.clearAccount()
            MainManager.shared.resetAll()
        }else if notification.name == .userLoggedIn{
            self.locationManager.startUpdatingLocation()
            
            
            
        }
        
        
    }
    @objc func handleAuthState(_ notification:Notification){
        
    }
}

// MARK: - Private
private extension HomeViewController {
    
}
