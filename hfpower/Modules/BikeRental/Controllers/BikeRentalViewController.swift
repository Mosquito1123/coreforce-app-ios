//
//  BikeRentalViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

import UIKit
protocol BikeRentalViewControllerDelegate{
    func rentBike(number:String?)
}
class BikeRentalViewController: UIViewController,UIGestureRecognizerDelegate{
 
    // MARK: - Accessor
    @objc var batteryType:HFBatteryTypeList?
    var bikeNumber:String = ""
    var depositService:HFDepositService?
    var packageCard:HFPackageCardModel?
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
        self.loadBikeData()

    }
    func loadData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"
        
        var params = [String: Any]()
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        params["largeTypeId"] = self.batteryType?.id
        self.getData(ourPackageCardUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let dataList = body["list"] as? [[String: Any]]{
                var items = [BuyPackageCard]()
                items.append(BuyPackageCard(title: "电池型号",subtitle: self.batteryType?.name, identifier: BatteryTypeViewCell.cellIdentifier(), icon:  "battery_type"))
                let limitedList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 2}
                if limitedList.count != 0{
                    items.append(BuyPackageCard(title: "限时特惠",subtitle: "", identifier: LimitedTimePackageCardViewCell.cellIdentifier(),items: limitedList))
                }
                let newList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 3}
                if newList.count != 0{
                    items.append(BuyPackageCard(title: "新人专享",subtitle: "", identifier: NewComersPackageCardViewCell.cellIdentifier(),items: newList))
                }
                let buyList = ((HFPackageCardModel.mj_objectArray(withKeyValuesArray: dataList) as? [HFPackageCardModel]) ?? []).filter { $0.category == 1}
                if buyList.count != 0{
                    items.append(BuyPackageCard(title: "换电不限次套餐",subtitle: self.batteryType?.name, identifier: BuyPackageCardPlansViewCell.cellIdentifier(),items: buyList))
                }
                items.append(BuyPackageCard(title: "用户须知",subtitle: "", identifier: UserIntroductionsViewCell.cellIdentifier()))
                self.items = items
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
        
    }
    func loadBikeData(){
        
    }
}

// MARK: - Setup
private extension BikeRentalViewController {
    
    private func setupNavbar() {
        self.title = "电车租赁"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
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
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.view.addSubview(self.tableView)
        self.view.addSubview(bottomView)
        bottomView.submittedAction = {sender in
            self.showActionSheet(["wechat","alipay"], ["微信支付","支付宝支付"], "取消") { section, row in
                self.presentedViewController?.dismiss(animated: true)
                let id = self.bottomView.model?.id ?? 0
                
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
            if let result = resultDic as? [String:Any],let resultStatus = result["resultStatus"] as? Int{
                if resultStatus == 9000{
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
extension BikeRentalViewController:UITableViewDataSource,UITableViewDelegate {
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
                let limitedCell =  self.getCell(byType: LimitedTimePackageCardViewCell.self)
                limitedCell?.cancelAllSelected()
                
                let newCell =  self.getCell(byType: NewComersPackageCardViewCell.self)
                newCell?.cancelAllSelected()
                
                self.bottomView.model = item.items?[indexPath.item]
            }
        }else if let cellx = cell as? LimitedTimePackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                commonCell?.cancelAllSelected()
                
                let newCell =  self.getCell(byType: NewComersPackageCardViewCell.self)
                newCell?.cancelAllSelected()
                
                self.bottomView.model = item.items?[indexPath.item]
            }
        }else if let cellx = cell as? NewComersPackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                commonCell?.cancelAllSelected()
                
                let limitedCell =  self.getCell(byType: LimitedTimePackageCardViewCell.self)
                limitedCell?.cancelAllSelected()
                self.bottomView.model = item.items?[indexPath.item]
            }
        }
        return cell
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
        var item = self.items[indexPath.row]
        if item.title  == "已购套餐"{
            let myPackageCardListViewController = MyPackageCardListViewController()
            myPackageCardListViewController.selectedBlock = { model in
                if let packageCard = model{
                    let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                    commonCell?.cancelAllSelected()
                    let limitedCell =  self.getCell(byType: LimitedTimePackageCardViewCell.self)
                    limitedCell?.cancelAllSelected()
                    let newCell =  self.getCell(byType: NewComersPackageCardViewCell.self)
                    newCell?.cancelAllSelected()
                    
                }
                self.bottomView.model = model
                self.packageCard = model
                item.boughtPackageCard = model
                self.items[indexPath.row] = item
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
      
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
        }else if item.title == "费用结算"{
            let couponListViewController = CouponListViewController()
            couponListViewController.couponType = 2
            couponListViewController.deviceNumber = self.bikeNumber
            let nav = UINavigationController(rootViewController: couponListViewController)
            nav.modalPresentationStyle = .custom
            let delegate =  CustomTransitioningDelegate()
            nav.transitioningDelegate = delegate
            
            if #available(iOS 13.0, *) {
                nav.isModalInPresentation = true
            } else {
                // Fallback on earlier versions
            }
            
            self.present(nav, animated: true, completion: nil)
        }else if item.title == "电池型号"{
            //           let chooseBatteryTypeViewController =  ChooseBatteryTypeViewController()
            //            self.navigationController?.pushViewController(chooseBatteryTypeViewController, animated: true)
            
        }
    }
    
    
}

// MARK: - Request
private extension BikeRentalViewController {
    
}

// MARK: - Action
@objc private extension BikeRentalViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension BikeRentalViewController {
    
}
