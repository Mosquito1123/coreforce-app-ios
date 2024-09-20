//
//  CabinetListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit
import CoreLocation
class CabinetListViewController: BaseTableViewController<CabinetListViewCell,HFCabinet>{
    
    // MARK: - Accessor
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)

    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
    }
    func loadData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"
        var params = [String: Any]()
        let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()
        if orderInfo.id != nil {
            params = ["tempStorageSw": true]
        }
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        params["lon"] = coordinate.longitude
        params["lat"] = coordinate.latitude
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
}

// MARK: - Setup
private extension CabinetListViewController {
    
    private func setupNavbar() {
        self.title = "电柜列表"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
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
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.view.addSubview(self.tableView)
       
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
    }
}

// MARK: - Public


// MARK: - Request
private extension CabinetListViewController {
    
}

// MARK: - Action
@objc private extension CabinetListViewController {
    
}

// MARK: - Private
private extension CabinetListViewController {
    
}
