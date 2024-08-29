//
//  SearchCabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import CoreLocation
class SearchCabinetListViewController: BaseTableViewController<CabinetListViewCell,CabinetSummary>,CLLocationManagerDelegate {
    
    // MARK: - Accessor
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var locationView:CabinetLocationView = {
        let view = CabinetLocationView()
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
    func loadData(){
        

        locationView.location = formatDateToChinese(date: Date())

       
        NetworkService<BusinessAPI,CabinetListResponse>().request(.cabinetList(tempStorageSw: nil, cityCode: CityCodeManager.shared.cityCode, lon: coordinate.longitude, lat:coordinate.latitude)) { result in
            switch result{
            case .success(let response):
                self.items = response?.list ?? []
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                
            }
        }
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
//        view.addSubview(headerView)
        
        locationView.relocate = { bt in
            self.locationManager.requestLocation()
        }
        view.addSubview(locationView)
        view.addSubview(tableView)
       
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
            
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

        ])
    }
}

// MARK: - Public
extension SearchCabinetListViewController{
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
                NotificationCenter.default.post(name: .cityChanged, object: nil)
                self.locationView.location = self.formatDateToChinese(date: Date())

                NetworkService<BusinessAPI,CabinetListResponse>().request(.cabinetList(tempStorageSw: nil, cityCode: CityCodeManager.shared.cityCode, lon: self.coordinate.longitude, lat:self.coordinate.latitude)) { result in
                    switch result{
                    case .success(let response):
                        self.items = response?.list ?? []
                    case .failure(let error):
                        self.showError(withStatus: error.localizedDescription)
                        
                    }
                }
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
