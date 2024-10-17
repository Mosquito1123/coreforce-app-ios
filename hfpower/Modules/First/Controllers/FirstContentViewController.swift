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

    func updateData(coordinate: CLLocationCoordinate2D?, location: String? = nil, distance: String? = nil, largeTypeId: String? = nil, powerLevel: String? = nil) {
        let dispatchGroup = DispatchGroup()
        
        // 定义用于存储请求结果的变量
        var components: [CabinetFilter] = []
        var newPackageCards: [HFPackageCardModel] = []
        var cabinetItems: [HFCabinet] = []
        var memberItems: [FirstContent] = []
        var showHeader: Bool = false
        let cityCode = CityCodeManager.shared.cityCode?.replacingLastTwoCharactersWithZeroes() ?? "370200"

        // 构建请求
        let packageCardParams = ["cityCode": cityCode]
        let cabinetParams = createCabinetParams(coordinate: coordinate, location: location, distance: distance, largeTypeId: largeTypeId, powerLevel: powerLevel, cityCode: cityCode)

        // 请求套餐卡片数据
        fetchPackageCards(with: packageCardParams, in: dispatchGroup) { result in
            newPackageCards = result.filter { $0.category == 3 }
        }

        // 请求筛选条件数据
        fetchFilterComponents(with: packageCardParams, in: dispatchGroup) { result in
            components = result
        }

        // 请求电柜列表数据
        fetchCabinetList(with: cabinetParams, in: dispatchGroup) { result in
            cabinetItems = result
        }

        // 请求会员信息
        fetchMemberInfo(in: dispatchGroup) { isAuth in
            showHeader = (isAuth == 1)
        }

        // 所有请求完成后的处理
        dispatchGroup.notify(queue: .main) {
            memberItems = self.prepareMemberItems(showHeader: showHeader, newPackageCards: newPackageCards, cabinetItems: cabinetItems)
            self.items = memberItems
            self.components = components
        }
    }

    // MARK: - Helper Methods

    private func createCabinetParams(coordinate: CLLocationCoordinate2D?, location: String?, distance: String?, largeTypeId: String?, powerLevel: String?, cityCode: String) -> [String: Any] {
        var params: [String: Any] = ["cityCode": cityCode]
        if let coordinate = coordinate {
            params["lon"] = coordinate.longitude
            params["lat"] = coordinate.latitude
        }
        params["location"] = location
        params["distance"] = distance
        params["largeTypeId"] = largeTypeId
        params["powerLevel"] = powerLevel
        return params
    }

    private func fetchPackageCards(with params: [String: Any], in group: DispatchGroup, completion: @escaping ([HFPackageCardModel]) -> Void) {
        group.enter()
        getData(ourPackageCardUrl, param: params, isLoading: true) { responseObject in
            guard let dataList = ((responseObject as? [String: Any])?["body"] as? [String: Any])?["list"] as? [[String: Any]] else {
                completion([])
                group.leave()
                return
            }
            let packageCards = HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel] ?? []
            completion(packageCards)
            group.leave()
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            group.leave()
        }
    }

    private func fetchFilterComponents(with params: [String: Any], in group: DispatchGroup, completion: @escaping ([CabinetFilter]) -> Void) {
        group.enter()
        getData(largeTypeUrl, param: params, isLoading: false) { responseObject in
            guard let list = ((responseObject as? [String: Any])?["body"] as? [String: Any])?["list"] as? [[String: Any]] else {
                completion([])
                group.leave()
                return
            }
            let items = (HFBatteryTypeList.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryTypeList]) ?? []
            let filterItems = items.map { CabinetFilterItem(id: $0.id.intValue, title: $0.name, content: $0.id.stringValue, selected: false) }
            let components: [CabinetFilter] = [
                CabinetFilter(id: 0, title: "距离最近", icon: "distance", type: .distance, filterItems: [
                    CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                    CabinetFilterItem(id: 1, title: "1km", content: "1000", selected: false)
                ]),
                CabinetFilter(id: 1, title: "电池类型", icon: "type", type: .type, filterItems: [CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true)] + filterItems),
                CabinetFilter(id: 2, title: "电池电量", icon: "power", type: .power, filterItems: [
                    CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                    CabinetFilterItem(id: 1, title: ">90%", content: "1", selected: false)
                ])
            ]
            completion(components)
            group.leave()
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            group.leave()
        }
    }

    private func fetchCabinetList(with params: [String: Any], in group: DispatchGroup, completion: @escaping ([HFCabinet]) -> Void) {
        group.enter()
        getData(cabinetListUrl, param: params, isLoading: true) { responseObject in
            guard let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                      let pageResult = body["pageResult"] as? [String: Any],
          let dataList = pageResult["dataList"] as? [[String: Any]] else {
                completion([])
                group.leave()
                return
            }
            let cabinetItems = HFCabinet.mj_objectArray(withKeyValuesArray: dataList) as? [HFCabinet] ?? []
            completion(cabinetItems)
            group.leave()
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            group.leave()
        }
    }

    private func fetchMemberInfo(in group: DispatchGroup, completion: @escaping (Int) -> Void) {
        group.enter()
        getData(memberUrl, param: [:], isLoading: false) { responseObject in
            guard let memberData = HFMember.mj_object(withKeyValues: ((responseObject as? [String: Any])?["body"] as? [String: Any])?["member"]) else {
                completion(0)
                group.leave()
                return
            }
            completion(Int(truncating: memberData.isAuth))
            group.leave()
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            group.leave()
        }
    }

    private func prepareMemberItems(showHeader: Bool, newPackageCards: [HFPackageCardModel], cabinetItems: [HFCabinet]) -> [FirstContent] {
        var memberItems: [FirstContent] = []
        let jsonString = HFPackageCardModel.mj_keyValuesArray(withObjectArray: newPackageCards).mj_JSONString()
        
        let headerContent = FirstContent(id: 0, title: showHeader ? "购买套餐" : "未实名", items: [
            FirstContentItem(id: 0, identifier: showHeader ? PersonalPackageCardViewCell.cellIdentifier() : AuthorityViewCell.cellIdentifier(), title: showHeader ? "购买套餐" : "未实名"),
            FirstContentItem(id: 1, identifier: FirstContentActivityViewCell.cellIdentifier(), title: "新人专享", extra: jsonString)
        ])
        memberItems.append(headerContent)

        if !cabinetItems.isEmpty {
            let cabinetList = cabinetItems.enumerated().map { (index, value) in
                FirstContentItem(id: index, identifier: CabinetListViewCell.cellIdentifier(), title: "", extra: value.mj_JSONString())
            }
            let cabinetContent = FirstContent(id: 1, identifier: FirstContentCabinetListHeaderView.viewIdentifier(), title: "电柜列表", items: cabinetList)
            memberItems.append(cabinetContent)
        }
        
        return memberItems
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
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = items[indexPath.section].items?[indexPath.row],
              let identifier = item.identifier else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configureCell(cell, with: item)
        return cell
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionIdentifier = items[section].identifier,
              let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier) as? FirstContentCabinetListHeaderView else {
            return nil
        }

        view.components = components
        view.locationView.location = ""
        view.locationView.relocate = { [weak self] _ in
            self?.locationManager.startUpdatingLocation()
        }
        view.componentsBlock = { [weak self] distance,largeTypeId,powerLevel in
            self?.updateData(coordinate: self?.coordinate, distance: distance,largeTypeId: largeTypeId,powerLevel:powerLevel)
        }

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return items[section].identifier != nil ? 88 : 0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let item = items[indexPath.section].items?[indexPath.row] else { return }
        configureCellActions(cell, with: item)
    }

    // MARK: - Cell Configuration
    private func configureCell(_ cell: UITableViewCell, with item: FirstContentItem) {
        switch cell {
        case let cabinetCell as CabinetListViewCell:
            if let cabinet = HFCabinet.mj_object(withKeyValues: item.extra) {
                cabinetCell.element = cabinet
            }
        case let activityCell as FirstContentActivityViewCell:
            activityCell.element = item
        default:
            break
        }
    }

    private func configureCellActions(_ cell: UITableViewCell, with item: FirstContentItem) {
        switch cell {
        case let cabinetCell as CabinetListViewCell:
            configureCabinetCellActions(cabinetCell, with: item)
        case let authorityCell as AuthorityViewCell:
            authorityCell.sureAction = { [weak self] _ in
                self?.navigateTo(RealNameAuthViewController())
            }
        case let packageCardCell as PersonalPackageCardViewCell:
            packageCardCell.sureAction = { [weak self] _ in
                self?.navigateTo(PackageCardChooseServiceViewController())
            }
        case let activityCell as FirstContentActivityViewCell:
            activityCell.didSelectItemBlock = { [weak self] _, _ in
                self?.navigateTo(ChooseBatteryTypeViewController())
            }
        default:
            break
        }
    }

    // MARK: - Cabinet Cell Actions
    private func configureCabinetCellActions(_ cell: CabinetListViewCell, with item: FirstContentItem) {
        guard let cabinet = HFCabinet.mj_object(withKeyValues: item.extra) else { return }

        cell.giftAction = { [weak self] _ in
            self?.navigateTo(ChooseBatteryTypeViewController())
        }

        cell.detailAction = { [weak self] _ in
            let detailVC = CabinetDetailViewController()
            detailVC.id = cabinet.id
            detailVC.number = cabinet.number
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }

        cell.navigateAction = { [weak self] _ in
            guard let lat = cabinet.bdLat?.doubleValue,
                  let lng = cabinet.bdLon?.doubleValue,
                  let number = cabinet.number else {
                self?.showError(withStatus: "该电柜坐标数据有误")
                return
            }
            self?.mapNavigation(lat: lat, lng: lng, address: number, currentController: self)
        }
    }

    // MARK: - Navigation Helper
    private func navigateTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
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

