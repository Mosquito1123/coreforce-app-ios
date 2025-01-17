//
//  BuyPackageCardViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit

class BuyPackageCardViewController: BaseViewController {
    
    // MARK: - Accessor
    var batteryDetail:HFBatteryDetail?
    var packageCard:HFPackageCardModel?
    @objc var batteryType:HFBatteryTypeList?
    var items = [BuyPackageCard](){
        didSet{
            self.tableView.reloadData()
            
        }
    }
    // MARK: - Subviews
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BatteryTypeViewCell.self, forCellReuseIdentifier: BatteryTypeViewCell.cellIdentifier())
        tableView.register(BuyPackageCardPlansViewCell.self, forCellReuseIdentifier: BuyPackageCardPlansViewCell.cellIdentifier())
        tableView.register(BoughtPlansViewCell.self, forCellReuseIdentifier: BoughtPlansViewCell.cellIdentifier())
        tableView.register(FeeDetailViewCell.self, forCellReuseIdentifier: FeeDetailViewCell.cellIdentifier())
        tableView.register(FeeDetailSecondViewCell.self, forCellReuseIdentifier: FeeDetailSecondViewCell.cellIdentifier())
        tableView.register(RecommendViewCell.self, forCellReuseIdentifier: RecommendViewCell.cellIdentifier())
        tableView.register(UserIntroductionsViewCell.self, forCellReuseIdentifier: UserIntroductionsViewCell.cellIdentifier())
        tableView.register(DepositServiceViewCell.self, forCellReuseIdentifier: DepositServiceViewCell.cellIdentifier())
        tableView.register(NewComersPackageCardViewCell.self, forCellReuseIdentifier: NewComersPackageCardViewCell.cellIdentifier())
        tableView.register(LimitedTimePackageCardViewCell.self, forCellReuseIdentifier: LimitedTimePackageCardViewCell.cellIdentifier())
        tableView.register(NewComersPackageCardViewCell.self, forCellReuseIdentifier: NewComersPackageCardViewCell.cellIdentifier())
        
        return tableView
    }()
    lazy var bottomView: BuyPackageCardBottomView = {
        let view = BuyPackageCardBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        self.loadData()
        
    }
    func loadData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"
        
        var params = [String: Any]()
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        if let batteryDetail = self.batteryDetail{
            params["largeTypeId"] = batteryDetail.largeTypeId
        }else{
            params["largeTypeId"] = self.batteryType?.id
        }
        self.getData(ourPackageCardUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let dataList = body["list"] as? [[String: Any]]{
                var items = [BuyPackageCard]()
                items.append(BuyPackageCard(title: "电池型号",subtitle: "", identifier: BatteryTypeViewCell.cellIdentifier(), icon:  "battery_type",batteryDetail: self.batteryDetail,bigType: self.batteryType))
                let buyList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 1}
                if buyList.count != 0{
                    items.append(BuyPackageCard(title: "换电不限次套餐",subtitle: "", identifier: BuyPackageCardPlansViewCell.cellIdentifier(),items: buyList))
                }
                let limitedList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 2}
                if limitedList.count != 0{
                    items.append(BuyPackageCard(title: "限时特惠",subtitle: "", identifier: LimitedTimePackageCardViewCell.cellIdentifier(),items: limitedList))
                }
                let newList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 3}
                if newList.count != 0{
                    items.append(BuyPackageCard(title: "新人专享",subtitle: "", identifier: NewComersPackageCardViewCell.cellIdentifier(),items: newList))
                }
                items.append(BuyPackageCard(title: "费用结算",subtitle: "", identifier: FeeDetailSecondViewCell.cellIdentifier(),packageCard: self.packageCard,batteryDetail: self.batteryDetail))
                
                items.append(BuyPackageCard(title: "用户须知",subtitle: "", identifier: UserIntroductionsViewCell.cellIdentifier()))
                self.items = items
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
    }
    
}

// MARK: - Setup
private extension BuyPackageCardViewController {
    
    private func setupNavbar() {
        self.title = "购买套餐"
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.view.addSubview(self.tableView)
        self.view.addSubview(bottomView)
        bottomView.submittedAction = {sender in
            self.getData(memberUrl, param: [:], isLoading: false) { responseObject in
                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                   let member = body["member"] as? [String: Any],
                   let isAuth = member["isAuth"] as? Int,isAuth == 1{
                        self.showActionSheet(["wechat","alipay"], ["微信支付","支付宝支付"], "取消") { section, row in
                            self.presentedViewController?.dismiss(animated: true)
                            let id = self.packageCard?.id ?? 0
                            
                            if section == 1,row == 0{//取消
                            }else if section == 0,row == 0{//微信支付
                                self.postData(buyPackageCardUrl, param: ["payChannel":1,"from":"app","id":id], isLoading: true) { responseObject in
                                    if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let payData = body["payData"] as? [String: Any]{
                                        if let payDataModel = HFPayData.mj_object(withKeyValues: payData){
                                            self.wxPay(payDataModel)
                                        }
                                    }
                                } error: { error in
                                    self.showError(withStatus: error.localizedDescription)
                                }
                                
                            }else if section == 0,row == 1{//支付宝支付
                                self.postData(buyPackageCardUrl, param: ["payChannel":2,"from":"app","id":id], isLoading: true) { responseObject in
                                    if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let payDataString = body["payData"] as? String{
                                        self.alipay(payDataString)
                                        
                                    }
                                } error: { error in
                                    self.showError(withStatus: error.localizedDescription)

                                }
                            }
                        }
                        
                    
                    
                }else{
                    self.showAlertController(titleText: "", messageText: "您还未实名认证，请先进行实名认证", okText: "实名认证", okAction: {
                        let realNameAuthVC = RealNameAuthViewController()
                        self.navigationController?.pushViewController(realNameAuthVC, animated: true)
                    }, isCancelAlert: true, cancelText: "取消") {
                        
                    }
                    
                }
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
            
        }
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    func alipay(_ payDataString:String!){
        AlipaySDK.defaultService().payOrder(payDataString, fromScheme: "hefengdongliAliSDK") { resultDic in
            if let resultStatus = resultDic?["resultStatus"] as? String{
                if resultStatus == "9000"{
                    self.navigationController?.popToRootViewController(animated: true)

                }else{
                    self.showError(withStatus: "支付失败")

                }
            }
        }
    }
    func wxPay(_ payData:HFPayData){
        let data: [String: Any] = [
                "appId": payData.appid,
                "nonceStr": payData.noncestr,
                "partnerId": "\(payData.partnerid)",  // String interpolation for integer values
                "package": payData.package,
                "prepayId": payData.prepayId,
                "sign": payData.sign,
                "timeStamp": "\(payData.timestamp)"  // String interpolation for integer values
            ]
            
        WXPayTools.sharedInstance.doWXPay(dataDict: data) {
            self.navigationController?.popToRootViewController(animated: true)
        } payFailed: {
            self.showError(withStatus: "支付失败")
        }

    }
}

// MARK: - Public
extension BuyPackageCardViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        guard let identifier = item.identifier else {return UITableViewCell()}
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BaseTableViewCell<BuyPackageCard> else {return BaseTableViewCell<BuyPackageCard>()}
        cell.element = item
        
        if let cellx = cell as? BuyPackageCardPlansViewCell{
            
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.updateItem(byType: LimitedTimePackageCardViewCell.self)
                self.updateItem(byType: NewComersPackageCardViewCell.self)
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()
            }
        }else if let cellx = cell as? LimitedTimePackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.updateItem(byType: BuyPackageCardPlansViewCell.self)
                self.updateItem(byType: NewComersPackageCardViewCell.self)
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()
            }
        }else if let cellx = cell as? NewComersPackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.updateItem(byType: BuyPackageCardPlansViewCell.self)
                self.updateItem(byType: LimitedTimePackageCardViewCell.self)
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()
            }
        }
        return cell
    }
    func updateItem<T: UITableViewCell>(byType object: T.Type){
        let commonCell = self.getCell(byType: object)
        let selector = #selector(BuyPackageCardProtocol.cancelAllSelected)

        if commonCell?.responds(to: #selector(BuyPackageCardProtocol.cancelAllSelected)) == true{
            commonCell?.perform(selector)
        }
        let commonItem = self.items.first { p in
            return p.identifier == String(describing: object)
        }
        self.dataChange(commonItem)
    }
    private func dataChange(_ element:BuyPackageCard?){
        if let items = element?.items{
            for i in 0..<items.count {
                if items[i].selected == NSNumber(value: true) {
                    items[i].selected = NSNumber(value: false) // 取消选中
                    break
                }
            }
        }
       
    }
    fileprivate func updateDatas(){
        let newPackageCard  = BuyPackageCard(title: "费用结算",subtitle: "", identifier: FeeDetailSecondViewCell.cellIdentifier(),packageCard: self.packageCard,batteryDetail:self.batteryDetail, bigType: self.batteryType)
        self.updateItem(where: { packageCard in
            return packageCard.identifier == newPackageCard.identifier
        }, with: newPackageCard)
    }
    func updateItem(where condition: (BuyPackageCard) -> Bool, with newItem: BuyPackageCard) {
        self.bottomView.element = newItem
        // 1. 查找符合条件的项的索引
        if let index = self.items.firstIndex(where: condition) {
            // 2. 替换数据源中的这一项
            self.items[index] = newItem
            
            // 3. 构建索引路径，表示要刷新的位置
            let indexPath = IndexPath(row: index, section: 0)
            
            // 4. 刷新指定的 Cell，无论是否显示
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    func getCell<T: UITableViewCell>(byType object: T.Type) -> T?{
        if let index = self.items.firstIndex(where: { $0.identifier == String(describing: object) }) {
            let indexPath = IndexPath(row: index, section: 0) // 假设只有一个 section
            if let cell = tableView.cellForRow(at: indexPath) as? T{
                // 此处可以使用获取的 cell
                return cell
            } else {
                return nil
            }
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        if item.title  == "已购套餐"{
            let myPackageCardListViewController = MyPackageCardListViewController()
            let nav = UINavigationController(rootViewController: myPackageCardListViewController)
            nav.modalPresentationStyle = .custom
            let delegate =  CustomTransitioningDelegate()
            nav.transitioningDelegate = delegate
            
            if #available(iOS 13.0, *) {
                nav.isModalInPresentation = true
            } else {
                // Fallback on earlier versions
            }
            
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
}

// MARK: - Request
private extension BuyPackageCardViewController {
    
}

// MARK: - Action
@objc private extension BuyPackageCardViewController {
    
}

// MARK: - Private
private extension BuyPackageCardViewController {
    
}
