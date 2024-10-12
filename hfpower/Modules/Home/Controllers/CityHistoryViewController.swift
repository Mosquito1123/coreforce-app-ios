//
//  CityHistoryViewController.swift
//  hfpower
//
//  Created by EDY on 2024/10/12.
//

import UIKit
import EmptyDataSet_Swift
import CoreLocation
class CityHistoryViewController: BaseViewController {
    
    // MARK: - Accessor
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // 在这里可以进行其他的配置
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    var items:[CityHistory] = [CityHistory](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(CityHistoryViewCell.self, forCellReuseIdentifier: CityHistoryViewCell.cellIdentifier())
        tableView.register(CityHistoryViewHeaderView.self, forHeaderFooterViewReuseIdentifier: CityHistoryViewHeaderView.viewIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: 0xF7F7F7FF)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
    }
    func loadData(){
        let cityHistoryItems = CityCodeManager.shared.getHistory().enumerated().map { (index,city) in
            return CityHistoryItem(id: index, title: city.cityName, content: "", extra: "",isCurrent: false)
        }
        self.items = [
            CityHistory(id: 0, title: "当前位置", content: "", extra: "",items:
                            [
                                CityHistoryItem(id: 0, title: CityCodeManager.shared.cityName, content: "", extra: "",isCurrent: true)
                            ]
                       ),
            CityHistory(id: 1, title: "历史位置", content: "", extra: "",items:
                            cityHistoryItems
                       )
        ]
    }
}
extension CityHistoryViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showError(withStatus: error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else
        { return }
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
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                
                
                
            }
        }
        
        
        
        
    }
    
}
extension CityHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellCity = tableView.dequeueReusableCell(withIdentifier: CityHistoryViewCell.cellIdentifier(), for: indexPath) as? CityHistoryViewCell else {return CityHistoryViewCell()}
        cellCity.element = self.items[indexPath.section].items?[indexPath.row]
        return cellCity
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CityHistoryViewHeaderView.viewIdentifier()) as? CityHistoryViewHeaderView else {return CityHistoryViewHeaderView()}
        view.element = self.items[section]
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? CityHistoryViewCell{
            cellx.relocate = { sender in
                self.locationManager.startUpdatingLocation()
            }
            
        }
    }
}
extension CityHistoryViewController:EmptyDataSetSource,EmptyDataSetDelegate{
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "暂无内容",attributes: [.font:UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor(hex: 0x999999FF)])
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "no_data")
    }
}
// MARK: - Setup
private extension CityHistoryViewController {
    
    private func setupNavbar() {
        self.title = "当前城市"
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex: 0xF7F7F7FF)
        self.view.addSubview(self.tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ]
        )
    }
}

// MARK: - Public
extension CityHistoryViewController {
    
}

// MARK: - Request
private extension CityHistoryViewController {
    
}

// MARK: - Action
@objc private extension CityHistoryViewController {
    
}

// MARK: - Private
private extension CityHistoryViewController {
    
}
