//
//  FirstContentViewController.swift
//  hfpower
//
//  Created by EDY on 2024/10/14.
//

import UIKit
import FloatingPanel
import CoreLocation
class FirstContentViewController: UIViewController {
    var fpc:FloatingPanelController?
    // MARK: - Accessor
    var coordinate: CLLocationCoordinate2D?
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // 在这里可以进行其他的配置
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    var items:[FirstContent] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    var components:[CabinetFilter] = []
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PersonalHeaderViewCell.self, forCellReuseIdentifier: PersonalHeaderViewCell.cellIdentifier())
        tableView.register(PersonalPackageCardViewCell.self, forCellReuseIdentifier: PersonalPackageCardViewCell.cellIdentifier())
        tableView.register(PersonalDevicesViewCell.self, forCellReuseIdentifier: PersonalDevicesViewCell.cellIdentifier())
        tableView.register(PersonalAssetsViewCell.self, forCellReuseIdentifier: PersonalAssetsViewCell.cellIdentifier())
        tableView.register(PersonalMileageViewCell.self, forCellReuseIdentifier: PersonalMileageViewCell.cellIdentifier())
        tableView.register(PersonalOthersViewCell.self, forCellReuseIdentifier: PersonalOthersViewCell.cellIdentifier())
        tableView.register(AuthorityViewCell.self, forCellReuseIdentifier: AuthorityViewCell.cellIdentifier())
        tableView.register(FirstContentActivityViewCell.self, forCellReuseIdentifier: FirstContentActivityViewCell.cellIdentifier())
        tableView.register(CabinetListViewCell.self, forCellReuseIdentifier: CabinetListViewCell.cellIdentifier())
        tableView.register(FirstContentCabinetListHeaderView.self, forHeaderFooterViewReuseIdentifier: FirstContentCabinetListHeaderView.viewIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.locationManager.startUpdatingLocation()

    }

    func updateData(coordinate: CLLocationCoordinate2D?,location:String? = nil,distance:String? = nil,largeTypeId:String? = nil,powerLevel:String? = nil) {
        let dispatchGroup = DispatchGroup()

        // 用于存储请求结果的变量
        var components:[CabinetFilter] = [CabinetFilter]()
        var cabinetItems: [HFCabinet] = []
        var memberItems: [FirstContent] = []
        var headerContent: FirstContent?
        // 请求筛选条件
        let code = CityCodeManager.shared.cityCode ?? "370200"

        var xparams = [String: Any]()
        xparams["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        dispatchGroup.enter()

        self.getData(largeTypeUrl, param: xparams, isLoading:false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let list = body["list"] as? [[String:Any]]{
                let items = (HFBatteryTypeList.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryTypeList]) ?? []
//                self.items = items
                var temp  = [CabinetFilterItem]()
                temp.append(CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true))
                temp.append(contentsOf: items.map { CabinetFilterItem(id: $0.id.intValue, title: $0.name, content: $0.id.stringValue, selected: false)})
                components = [
                    
                    CabinetFilter(id: 0, title: "距离最近", icon: "distance", type: .distance,filterItems:
                                    [
                                        CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                                        CabinetFilterItem(id: 1, title: "1km", content: "1000", selected: false),
                    ]),
                    CabinetFilter(id: 1, title: "电池类型", icon: "type", type: .type,filterItems:temp),
                    CabinetFilter(id: 2, title: "电池电量", icon: "power", type: .power,filterItems: [
                        CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                        CabinetFilterItem(id: 1, title: ">90%", content: "1", selected: false),
                    ]),
                    
                ]

            }
            dispatchGroup.leave()

        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            dispatchGroup.leave()

        }
        // 请求电柜列表
        dispatchGroup.enter()
        let cityCode = CityCodeManager.shared.cityCode ?? "370200"
        var params = [String: Any]()
        let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()

        if orderInfo.id != nil {
            params = ["tempStorageSw": true]
        }
        params["cityCode"] = cityCode.replacingLastTwoCharactersWithZeroes()
        params["lon"] = coordinate?.longitude ?? 0
        params["lat"] = coordinate?.latitude ?? 0
        if let locationx = location {
            params["location"] = locationx
        }
        if let distance = distance {
            params["distance"] = distance
        }
        if let largeTypeId = largeTypeId {
            params["largeTypeId"] = largeTypeId
        }
        if let powerLevel = powerLevel {
            params["powerLevel"] = powerLevel
        }

        self.getData(cabinetListUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                let cabinetArray = (HFCabinet.mj_objectArray(withKeyValuesArray: dataList) as? [HFCabinet]) ?? []
                cabinetItems = cabinetArray
            }
            dispatchGroup.leave() // 任务完成
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            dispatchGroup.leave() // 即使出错也要leave，避免死锁
        }

        // 请求会员信息
        dispatchGroup.enter()
        self.getData(memberUrl, param: [:], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any] {
                let memberData = HFMember.mj_object(withKeyValues: body["member"])
                let isAuth = memberData?.isAuth
                
                if isAuth == 1 {
                    headerContent = FirstContent(id: 0, title: "购买套餐", items: [
                        FirstContentItem(id: 0, identifier: PersonalPackageCardViewCell.cellIdentifier(), title: "购买套餐"),
                        FirstContentItem(id: 1, identifier: FirstContentActivityViewCell.cellIdentifier(), title: "活动优惠")
                    ])
                    
                } else {
                    headerContent = FirstContent(id: 0, title: "未实名", items: [
                        FirstContentItem(id: 0, identifier: AuthorityViewCell.cellIdentifier(), title: "未实名")
                    ])

                }
            }
            dispatchGroup.leave() // 任务完成
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            dispatchGroup.leave() // 即使出错也要leave
        }

        // 当两个请求都完成时的处理
        dispatchGroup.notify(queue: .main) {
            // 两个请求都完成后执行的操作
            if let headerContentx = headerContent {
                memberItems.append(headerContentx)
            }
            let cabinetList = cabinetItems.enumerated().map { (index,value) in
                return FirstContentItem(id: index, identifier: CabinetListViewCell.cellIdentifier(), title: "",extra: value.mj_JSONString())
            }
            if cabinetList.count > 0{
                let cabinetContent = FirstContent(id: 1,identifier: FirstContentCabinetListHeaderView.viewIdentifier(), title: "电柜列表", items:cabinetList)
                memberItems.append(cabinetContent)
            }
            
            self.items = memberItems // 这里合并数据逻辑可以根据需求调整
            self.components = components
            self.tableView.reloadData() // 刷新 UI
        }

    }
}
extension FirstContentViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showError(withStatus: error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else
         { return }
        self.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let _ = error{
                
            }else{
                CityCodeManager.shared.placemark = placemarks?.first
                CityCodeManager.shared.cityName = placemarks?.first?.locality
                
                let code =  CityCodeHelper().getCodeByName(placemarks?.first?.locality ?? "")
                CityCodeManager.shared.cityCode = code
                CityCodeManager.shared.saveToHistory(newValue: City(cityCode: code, cityName: placemarks?.first?.locality ?? ""))
                NotificationCenter.default.post(name: .cityChanged, object: nil)
//                self.locationView.location = self.formatDateToChinese(date: Date())
                self.locationManager.stopUpdatingLocation()
                let distanceItem = self.components.first { filter in
                    return filter.type == .distance
                }?.filterItems?.first(where: { item in
                    return item.selected == true
                })
                let typeItem = self.components.first { filter in
                    return filter.type == .type
                }?.filterItems?.first(where: { item in
                    return item.selected == true
                })
                let powerItem = self.components.first { filter in
                    return filter.type == .power
                }?.filterItems?.first(where: { item in
                    return item.selected == true
                })
                self.updateData(coordinate: self.coordinate, distance: distanceItem?.content,largeTypeId: typeItem?.content,powerLevel:powerItem?.content)
                

            }
        }

       
        
        
    }
}
// MARK: - Setup
private extension FirstContentViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        view.addSubview(tableView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

// MARK: - Public
extension FirstContentViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.items[indexPath.section].items?[indexPath.row],let identifier = item.identifier else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIdentifier = self.items[section].identifier else {return nil}
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier) as? FirstContentCabinetListHeaderView else {return nil}
        view.components = self.components
        view.locationView.relocate = { bt in
            self.locationManager.startUpdatingLocation()
        }
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.items[section].identifier else {return 0}
        return 104
    }
}

// MARK: - Request
private extension FirstContentViewController {
    
}

// MARK: - Action
@objc private extension FirstContentViewController {
    
}

// MARK: - Private
private extension FirstContentViewController {
    
}
/*
class YourClass {
    var items: [FirstContent] = []

    init() {
        // 使用循环生成 100 个 FirstContent
        for i in 0..<100 {
            let content = FirstContent(id: i, title: "内容 \(i)", items: [
                FirstContentItem(id: 0, identifier: PersonalPackageCardViewCell.cellIdentifier(), title: "购买套餐 \(i)")
            ])
            items.append(content)
        }
    }
}
*/
