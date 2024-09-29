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
    @objc var bikeDetail:HFBikeDetail?{
        didSet{
            self.bikeNumber = bikeDetail?.number ?? ""
        }
    }
    var bikeNumber:String = ""
    var depositService:HFDepositService?
    var packageCard:HFPackageCardModel?
    var coupon:HFCouponData?
    var items = [BuyPackageCard](){
        didSet{
            self.tableView.reloadData()
            
        }
    }
    var payDeposit:Bool = true
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
    func refreshPackageCard(){
        var items = [BuyPackageCard]()
        let buyList = [1,2,3,5,7,10].enumerated().map { (index,value) in
            let packageCard = HFPackageCardModel()
            packageCard.id = NSNumber(value: index)
            packageCard.price = NSNumber(value:(self.bikeDetail?.planRent ?? 0) * value)
            packageCard.days = NSNumber(value:(self.bikeDetail?.duration.doubleValue ?? 0)*value)
            packageCard.count = NSNumber(value:value)
            packageCard.originalPrice = NSNumber(value: (self.bikeDetail?.planRent ?? 0)*value * 1.2)
            return packageCard
        }
        items.append(BuyPackageCard(title: "机车套餐",subtitle: "", identifier: BuyPackageCardPlansViewCell.cellIdentifier(),items: buyList))
        let depositService0 = HFDepositService()
        depositService0.id = 0
        depositService0.title = "支付宝免押"
        depositService0.content = "芝麻信用>550分"
        depositService0.selected = NSNumber(booleanLiteral: true)
        depositService0.amount = "0元"
        depositService0.authOrder = NSNumber(integerLiteral: 1)
        let depositService1 = HFDepositService()
        depositService1.id = 1
        depositService1.title = "支付押金"
        depositService1.content = "退租后，押金可退"
        depositService1.selected = NSNumber(booleanLiteral: false)
        depositService1.amount = "\(self.bikeDetail?.planDeposit ?? 0)元"
        depositService1.authOrder = NSNumber(integerLiteral: 0)
        let temp = self.payDeposit ? [
//            BuyPackageCard(title: "已购套餐",subtitle: "", identifier: BoughtPlansViewCell.cellIdentifier()),
            BuyPackageCard(title: "押金服务",subtitle: "", identifier: DepositServiceViewCell.cellIdentifier(),depositServices: [depositService0,depositService1]),
            BuyPackageCard(title: "费用结算",subtitle: "", identifier: FeeDetailViewCell.cellIdentifier(),packageCard: self.packageCard,bikeDetail: self.bikeDetail),
            BuyPackageCard(title: "推荐码（选填）",subtitle: "点击输入或扫描二维码", identifier: RecommendViewCell.cellIdentifier()),
            BuyPackageCard(title: "用户须知",subtitle: "", identifier: UserIntroductionsViewCell.cellIdentifier()),
        ]:[
//            BuyPackageCard(title: "已购套餐",subtitle: "", identifier: BoughtPlansViewCell.cellIdentifier()),
            BuyPackageCard(title: "费用结算",subtitle: "", identifier: FeeDetailViewCell.cellIdentifier(),packageCard: self.packageCard,bikeDetail: self.bikeDetail),
            BuyPackageCard(title: "推荐码（选填）",subtitle: "点击输入或扫描二维码", identifier: RecommendViewCell.cellIdentifier()),
            BuyPackageCard(title: "用户须知",subtitle: "", identifier: UserIntroductionsViewCell.cellIdentifier()),
        ]
        items.append(contentsOf: temp)
        self.items = items
    }
    
    func refreshCouponList(){

    }
    func loadBikeData(){
        var params = [String:Any]()
        params["locomotiveNumber"] = self.bikeNumber
        if let id = self.bikeDetail?.id{
            params["locomotiveId"] = id
        }
        self.getData(locomotiveUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let bike = body["locomotive"] as? [String:Any]{
                self.bikeDetail = HFBikeDetail.mj_object(withKeyValues: bike)
                if let payingOrderId = body["payingOrderId"] as? NSNumber{
                    self.showAlertController(titleText: "温馨提示", messageText: "您有订单尚未完成支付，取消订单将会返还已使用优惠券到您账户，是否取消？", okAction: {
                        let orderDetailVC = OrderDetailViewController()
                        orderDetailVC.id = payingOrderId
                        self.navigationController?.pushViewController(orderDetailVC, animated: true)
                    },isCancelAlert: true) {
                        self.postData(orderCancelUrl,
                                 param: ["orderId": payingOrderId],
                                 isLoading: true,
                                 success: { [weak self] responseObject in
                            self?.navigationController?.popViewController(animated: true)
                        },
                                 error: { error in
                            // 处理错误
                            self.showError(withStatus: error.localizedDescription)
                        })
                    }
                    
                }else{
                    if let isThird = body["isThird"] as? Bool,isThird{
                        let payWeb = BatteryPayWebViewController()
                        payWeb.orderPage = body["orderPage"] as? String
                        payWeb.renewalPage = body["renewalPage"] as? String
                        self.navigationController?.pushViewController(payWeb, animated: true)
                    }else{
                        if let payDeposit = body["payDeposit"] as? Bool,!payDeposit{//不需要押金
                            self.payDeposit = false
                        }else{//需要押金
                            self.payDeposit = true

                        }
                        self.refreshCouponList()
                        self.refreshPackageCard()
                    }
                    
                }
            }else{
                self.showWindowInfo(withStatus: "当前电车已出租或不可用，请重新选择电车")
                self.navigationController?.popViewController(animated: true)
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

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
                
                if section == 1,row == 0{//取消
                }else if section == 0,row == 0{//微信支付
                    self.placeAnOrder(payChannel: 1)
                    
                }else if section == 0,row == 1{//支付宝支付
                    self.placeAnOrder(payChannel: 2)

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
    func placeAnOrder(payChannel:Int){
        var params = [String: Any]()
        params["locomotiveNumber"] = self.bikeNumber
        params["locomotiveLeaseDuration"] = self.packageCard?.count ?? 0
        if let coupon = self.coupon{
            params["locomotiveCouponId"] = coupon.id
        }
        if  let cellx = self.getCell(byType: RecommendViewCell.self){
            params["storeMemberNumber"] = cellx.content

        }
        params["storeMemberId"] = self.bikeDetail?.memberId
        params["agentId"] = self.bikeDetail?.agentId
        params["authOrder"] = self.depositService?.authOrder ?? 1
        self.postData(orderUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any]{
                if let authData = body["authData"] as? String{
                    self.alipayAuth(authData)
                }else{
                    if let orderDetail = HFOrderDetailData.mj_object(withKeyValues: body["order"]){
                        self.postData(orderPayUrl, param: ["orderId":orderDetail.id,"payMethod":payChannel], isLoading: true) { responseObject in
                            
                            if payChannel == 1{
                                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let payData = body["payData"] as? [String: Any]{
                                    if let payDataModel = HFPayData.mj_object(withKeyValues: payData){
                                        self.wxPay(payDataModel)
                                    }
                                }
                            }else if payChannel == 2{
                                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let payDataString = body["payData"] as? String{
                                    self.alipay(payDataString)
                                    
                                }
                            }
                            
                            
                        } error: { error in
                            self.showError(withStatus: error.localizedDescription)

                        }
                    }
                    

                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    func alipayAuth(_ payDataString:String!){
        AlipaySDK.defaultService().payOrder(payDataString, fromScheme: "hefengdongliAliSDK") { resultDic in
            if let result = resultDic as? [String:Any],let resultStatus = result["resultStatus"] as? Int{
                if resultStatus == 9000{
                    self.showSuccess(withStatus: "支付宝信用免押成功")
                }else{
                    self.showError(withStatus: "支付宝信用免押失败")

                }
            }
        }
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
                
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()

            }
        }else if let cellx = cell as? LimitedTimePackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                commonCell?.cancelAllSelected()
                
                let newCell =  self.getCell(byType: NewComersPackageCardViewCell.self)
                newCell?.cancelAllSelected()
                
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()

            }
        }else if let cellx = cell as? NewComersPackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                commonCell?.cancelAllSelected()
                
                let limitedCell =  self.getCell(byType: LimitedTimePackageCardViewCell.self)
                limitedCell?.cancelAllSelected()
                self.packageCard = item.items?[indexPath.item]
                self.updateDatas()

            }
        }else if let cellx = cell as? DepositServiceViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.depositService = item.depositServices?[indexPath.item]
                self.updateDatas()

            }
        }else if let cellx = cell as? RecommendViewCell{
            cellx.scanAction = { [weak self] _ in
                let scanVC = HFScanViewController()
                scanVC.resultBlock = { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                    cellx.content = $0.strScanned
                }
                self?.navigationController?.pushViewController(scanVC, animated: true)
            }
        }
        return cell
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
        var item = self.items[indexPath.row]
        if item.title  == "已购套餐"{
            let myPackageCardListViewController = MyPackageCardListViewController()
            myPackageCardListViewController.selectedBlock = { model in
                if let _ = model{
                    let commonCell = self.getCell(byType: BuyPackageCardPlansViewCell.self)
                    commonCell?.cancelAllSelected()
                    let limitedCell =  self.getCell(byType: LimitedTimePackageCardViewCell.self)
                    limitedCell?.cancelAllSelected()
                    let newCell =  self.getCell(byType: NewComersPackageCardViewCell.self)
                    newCell?.cancelAllSelected()
                    
                }
                self.packageCard = model
                item.boughtPackageCard = model
                self.items[indexPath.row] = item
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                self.updateDatas()

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
            couponListViewController.selectedBlock = { coupon in
                self.coupon = coupon
                self.updateDatas()
            }
            couponListViewController.amount = self.packageCard?.price.stringValue ?? "0"
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
        }
    }
    fileprivate func updateDatas(){
        let newPackageCard  = BuyPackageCard(title: "费用结算",subtitle: "", identifier: FeeDetailViewCell.cellIdentifier(),packageCard: self.packageCard,bikeDetail: self.bikeDetail,coupon: self.coupon,depositService: self.depositService)
        self.updateItem(where: { packageCard in
            return packageCard.identifier == newPackageCard.identifier
        }, with: newPackageCard)
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
