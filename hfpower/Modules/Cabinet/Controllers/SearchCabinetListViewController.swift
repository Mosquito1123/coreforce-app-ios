//
//  SearchCabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import CoreLocation
import MKDropdownMenu
enum SearchCabinetListType:Int{
    case distance
    case type
    case power
}

class SearchCabinetListViewController: BaseTableViewController<CabinetListViewCell,HFCabinet>,CLLocationManagerDelegate,MKDropdownMenuDataSource,MKDropdownMenuDelegate,UITextFieldDelegate{
    func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return components.count
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        let items = self.components[component].filterItems ?? []
        return items.count
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, shouldUseFullRowWidthForComponent component: Int) -> Bool {
        return true
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForComponent component: Int) -> NSAttributedString? {
        let componentTitle = self.components[component].title ?? ""
        return NSAttributedString(string: componentTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex:0x666666FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForSelectedComponent component: Int) -> NSAttributedString? {
        let componentTitle = self.components[component].title ?? ""
        return NSAttributedString(string: componentTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex:0x1D2129FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13, weight: .medium)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let rowTitle = self.components[component].filterItems?[row].title ?? ""
        let selected = self.components[component].filterItems?[row].selected ?? false
        return NSAttributedString(string: rowTitle, attributes: [NSAttributedString.Key.foregroundColor:selected ? UIColor(hex:0x165DFFFF):UIColor(hex:0x1D2129FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, accessoryViewForRow row: Int, forComponent component: Int) -> UIView? {
        let selected = self.components[component].filterItems?[row].selected ?? false
        return selected ? UIImageView(image: UIImage(named: "icon_accessory_selected")) : nil
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        self.components[component].filterItems = self.components[component].filterItems?.map { option in
                    var newOption = option
                    newOption.selected = false
                    return newOption
                }
                
                // 设置当前选中的选项为 true
        self.components[component].filterItems?[row].selected = true
        dropdownMenu.reloadComponent(component)
//        dropdownMenu.closeAllComponents(animated: true)
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
        updateData(coordinate: self.coordinate,location:self.headerView.searchView.textField.text, distance: distanceItem?.content,largeTypeId: typeItem?.content,powerLevel:powerItem?.content)
    }
    var components:[CabinetFilter] = [
        
        CabinetFilter(id: 0, title: "距离最近", icon: "distance", type: .distance,filterItems:
                        [
                            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                            CabinetFilterItem(id: 1, title: "1km", content: "1000", selected: false),
        ]),
        CabinetFilter(id: 1, title: "电池类型", icon: "type", type: .type,filterItems: [
            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
        ]),
        CabinetFilter(id: 2, title: "电池电量", icon: "power", type: .power,filterItems: [
            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
            CabinetFilterItem(id: 1, title: ">90%", content: "1", selected: false),
        ]),
        
    ]{
        didSet{
            self.filterView.reloadAllComponents()
        }
    }
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
    // MARK: - Subviews
    lazy var headerView: SearchCabinetListHeaderView = {
        let view = SearchCabinetListHeaderView()
        view.searchView.textField.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var locationView:CabinetLocationView = {
        let view = CabinetLocationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var filterView:MKDropdownMenu = {
        let view = MKDropdownMenu()
        view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        view.componentSeparatorColor = UIColor(hex:0xF7F7F7FF)
        view.rowSeparatorColor = UIColor.white
        view.selectedComponentBackgroundColor = UIColor.white
        view.dropdownBackgroundColor = UIColor.white
        view.dropdownShowsBorder = false
        view.dropdownShowsTopRowSeparator = false
        view.dropdownShowsBottomRowSeparator = false
        view.disclosureIndicatorImage = UIImage(named: "icon_arrow_down")
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadComponentsData()
        updateData(coordinate: self.coordinate)
    }
    func loadComponentsData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"

        var params = [String: Any]()
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()

        self.getData(largeTypeUrl, param: params, isLoading:false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let list = body["list"] as? [[String:Any]]{
                let items = (HFBatteryTypeList.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryTypeList]) ?? []
//                self.items = items
                var temp  = [CabinetFilterItem]()
                temp.append(CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true))
                temp.append(contentsOf: items.map { CabinetFilterItem(id: $0.id.intValue, title: $0.name, content: $0.id.stringValue, selected: false)})
                self.components = [
                    
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
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
    }

    // 根据阿拉伯数字返回对应的中文数字
    func convertToChineseDate(dateString: String) -> String {
        // 中文数字字典
        let chineseNumbers: [String: String] = [
            "0": "〇", "1": "一", "2": "二", "3": "三", "4": "四", "5": "五",
            "6": "六", "7": "七", "8": "八", "9": "九","年":"年","月":"月","日":"日"
        ]

        // 拼接结果
        return dateString.map { chineseNumbers[$0.description] ?? "" }.joined()
    }

    // 格式化日期为中文格式，并使用自定义的中文数字
    func formatDateToChinese(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "y年M月d日"
        
        let formattedDate = dateFormatter.string(from: date)
        
        // 使用正则表达式替换数字为中文数字
        
        let chineseFormattedDate = convertToChineseDate(dateString: formattedDate)
        
        return chineseFormattedDate
    }
    func updateData(coordinate: CLLocationCoordinate2D?,location:String? = nil,distance:String? = nil,largeTypeId:String? = nil,powerLevel:String? = nil) {
        locationView.location = ""

        let code = CityCodeManager.shared.cityCode ?? "370200"
        var params = [String: Any]()
        let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()
        if orderInfo.id != nil {
            params = ["tempStorageSw": true]
        }
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
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
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]]{
                let cabinetArray = (HFCabinet.mj_objectArray(withKeyValuesArray: dataList) as? [HFCabinet]) ?? []
                self.items = cabinetArray
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)

        }

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let element = self.items[indexPath.row]
        if let cellx = cell as? CabinetListViewCell {
            cellx.giftAction = { sender in
                let chooseBatteryTypeViewController =  ChooseBatteryTypeViewController()
                self.navigationController?.pushViewController(chooseBatteryTypeViewController, animated: true)
            }
            cellx.detailAction = { sender in
                let cabinetDetailVC = CabinetDetailViewController()
                cabinetDetailVC.id = element.id
                cabinetDetailVC.number = element.number
                self.navigationController?.pushViewController(cabinetDetailVC, animated: true)
            }
            cellx.navigateAction = { sender in
                
                guard let lat = element.bdLat?.doubleValue,let lng = element.bdLon?.doubleValue,let number = element.number else {
                    self.showError(withStatus: "该电柜坐标数据有误")
                    return}
                self.mapNavigation(lat: lat, lng: lng, address: number, currentController: self)
            }
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        updateData(coordinate: self.coordinate,location:textField.text, distance: distanceItem?.content,largeTypeId: typeItem?.content,powerLevel:powerItem?.content)
    }
}

// MARK: - Setup
private extension SearchCabinetListViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        headerView.backAction = {bt in
            self.navigationController?.popViewController(animated: true)
            
        }
        self.navigationItem.titleView = headerView
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
        
        
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor.white
        locationView.relocate = { bt in
            self.locationManager.startUpdatingLocation()
        }
        view.addSubview(locationView)
        view.addSubview(tableView)
        view.addSubview(filterView)
       
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44),
//            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 44),
            locationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            filterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            filterView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 44),
            filterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        ])
    }
}

// MARK: - Public
extension SearchCabinetListViewController{
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
                self.updateData(coordinate: self.coordinate,location:self.headerView.searchView.textField.text, distance: distanceItem?.content,largeTypeId: typeItem?.content,powerLevel:powerItem?.content)
                

            }
        }

       
        
        
    }
}

// MARK: - Request
private extension SearchCabinetListViewController {
    
}

// MARK: - Action
@objc private extension SearchCabinetListViewController {
    
}

// MARK: - Private
private extension SearchCabinetListViewController {
    
}
