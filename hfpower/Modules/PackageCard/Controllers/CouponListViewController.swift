//
//  CouponListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit
import MJRefresh
class CouponListViewController: BaseTableViewController<CouponListViewCell,HFCouponData> {
    
    // MARK: - Accessor
    var selectedBlock:((_ model:HFCouponData?)->())?
    var couponType:Int = 1
    var deviceNumber:String = ""
    var amount:String = "0"
    var pageNum = 1
    var pageCount = 1
    override var title: String?{
        didSet{
            self.titleLabel.text = title
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 18,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var closeButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "filter_close")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - 590, width: self.view.frame.width, height: 590))
        view.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            // 处理不支持 `maskedCorners` 的 iOS 版本
        }
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0) // 替换 `RGBA` 函数
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 24.5
        button.layer.masksToBounds = true
        button.tintAdjustmentMode = .automatic
        button.setTitle("确定使用", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(submitButtonClick(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var submitButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupRefreshControl()
        setupLayout()
        self.loadData()
        
    }
    func setupRefreshControl() {
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshing))
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshing))
    }
    @objc func headerRefreshing() {
        // Implement your header refresh logic here
        // ...
        self.items.removeAll()
        pageNum = 1
        var params = [String: Any]()
        var urlString = couponMatchingUrl
        switch couponType{
        case 1:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        case 2:
            params["locomotiveNumber"] = self.deviceNumber
            urlString = locomotiveCouponMatchingUrl
        case 3:
            params["batteryNumber"] = self.deviceNumber
            urlString = changeCardCouponMatchingUrl
        default:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        }
        params["page"] = self.pageNum
        params["amount"] = self.amount
        self.getData(urlString, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? [])
                self.pageNum = 1
                
                let total = pageResult["total"] as? NSNumber ?? 0
                let size = pageResult["size"] as? NSNumber ?? 1
                
                self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.resetNoMoreData()
        }
        
        
        
    }
    
    @objc func footerRefreshing() {
        // Implement your footer refresh logic here
        // ...
        if pageNum + 1 > pageCount {
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            return
        }
        pageNum = pageNum + 1
        var params = [String: Any]()
        var urlString = couponMatchingUrl
        switch couponType{
        case 1:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        case 2:
            params["locomotiveNumber"] = self.deviceNumber
            urlString = locomotiveCouponMatchingUrl
        case 3:
            params["batteryNumber"] = self.deviceNumber
            urlString = changeCardCouponMatchingUrl
        default:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        }
        params["page"] = self.pageNum
        params["amount"] = self.amount
        self.getData(urlString, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                let addItems = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? [])
                self.items.append(contentsOf: addItems)
                self.tableView.mj_footer?.endRefreshing()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_footer?.endRefreshing()
        }
        
        
    }
    func loadData(){
        pageNum = 1
        var params = [String: Any]()
        var urlString = couponMatchingUrl
        switch couponType{
        case 1:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        case 2:
            params["locomotiveNumber"] = self.deviceNumber
            urlString = locomotiveCouponMatchingUrl
        case 3:
            params["batteryNumber"] = self.deviceNumber
            urlString = changeCardCouponMatchingUrl
        default:
            params["batteryNumber"] = self.deviceNumber
            urlString = couponMatchingUrl
        }
        params["page"] = self.pageNum
        params["amount"] = self.amount
        self.getData(urlString, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {
                
                self.items = (HFCouponData.mj_objectArray(withKeyValuesArray: dataList) as? [HFCouponData] ?? [])
                self.pageNum = 1
                
                let total = pageResult["total"] as? NSNumber ?? 0
                let size = pageResult["size"] as? NSNumber ?? 1
                
                self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_footer?.resetNoMoreData()
        }
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 更新选中状态
        for i in 0..<items.count {
            items[i].selected = NSNumber(value: (i == indexPath.row) ? !items[i].selected.boolValue : false)
        }
        
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
private extension CouponListViewController {
    
    private func setupNavbar() {
        self.title = "我的优惠券"
        
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = .clear
        
        // 添加子视图
        self.view.addSubview(mainView)
        mainView.addSubview(closeButton)
        mainView.addSubview(titleLabel)
        mainView.addSubview(tableView)
        tableView.backgroundColor = UIColor(hex:0xF8F8F8FF)
        mainView.addSubview(submitButtonBackgroundView)
        submitButtonBackgroundView.addSubview(submitButton)
    }
    
    private func setupLayout() {
        // 设置 mainView 的约束
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 590/812.0)
        ])
        
        // 设置 closeButton、titleLabel、tableView、submitButtonBackgroundView 和 submitButton 的约束
        NSLayoutConstraint.activate([
            // closeButton 的约束
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            closeButton.widthAnchor.constraint(equalToConstant: 18),
            closeButton.heightAnchor.constraint(equalToConstant: 18),
            
            // titleLabel 的约束
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -15),
            
            // tableView 的约束
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: submitButtonBackgroundView.topAnchor),
            
            // submitButtonBackgroundView 的约束
            submitButtonBackgroundView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            submitButtonBackgroundView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            submitButtonBackgroundView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            submitButtonBackgroundView.heightAnchor.constraint(equalToConstant: 90),
            
            // submitButton 的约束
            submitButton.topAnchor.constraint(equalTo: submitButtonBackgroundView.topAnchor, constant: 12),
            submitButton.leadingAnchor.constraint(equalTo: submitButtonBackgroundView.leadingAnchor, constant: 12),
            submitButton.trailingAnchor.constraint(equalTo: submitButtonBackgroundView.trailingAnchor, constant: -12),
            submitButton.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}

// MARK: - Public
extension CouponListViewController {
    
}

// MARK: - Request
private extension CouponListViewController {
    
}

// MARK: - Action
@objc private extension CouponListViewController {
    @objc func close(_ sender:UIButton){
        self.selectedBlock?(nil)
        self.dismiss(animated: true)
    }
    @objc func submitButtonClick(_ sender:UIButton){
        var selectedItems = [HFCouponData]()
        for item in self.items {
            if item.selected.boolValue {
                selectedItems.append(item)
            }
        }
        self.selectedBlock?(selectedItems.first)
        self.dismiss(animated: true)
    }
}

// MARK: - Private
private extension CouponListViewController {
    
}
