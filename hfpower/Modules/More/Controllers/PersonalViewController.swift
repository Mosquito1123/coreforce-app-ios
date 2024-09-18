//
//  MyViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
class PersonalViewController: BaseViewController, BatteryRentalViewControllerDelegate, BatteryReplacementViewControllerDelegate, BikeRentalViewControllerDelegate {
    func rentBike(number: String?) {
        
    }
    
    func batteryReplacement(id: Int?, number: String?) {
        
    }
    
    func rentBattery(number: String?) {
        
    }
    
    func cabinetRentBattery(number: String?) {
        self.postData(cabinetScanRentUrl, param: ["cabinetNumber":number ?? ""], isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let list = body["list"]{
                if let typeList = HFBatteryRentalTypeInfo.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryRentalTypeInfo]{
                  let batteryRentalChooseTypeViewController = BatteryRentalChooseTypeViewController()
                    batteryRentalChooseTypeViewController.items = typeList
                    self.navigationController?.pushViewController(batteryRentalChooseTypeViewController, animated: true)
                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
    }
    
    
    // MARK: - Accessor
    var items = [PersonalList](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
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
        
    }
    
    func loadMemberData(){
        self.refreshBatteryDataList {
            
        } bikeDataBlock: {
            
        } batteryDepositDataBlock: {
            
        } complete: { result in
            
        }
        
        self.getData(memberUrl, param: [:], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any] {
                
                let memberData = HFMember.mj_object(withKeyValues: body["member"])
                let changeCardInfoData = HFChangeCardInfo.mj_object(withKeyValues: body["changeCardInfo"])
                let isAuth = memberData?.isAuth
                if isAuth == 1{
                    
                            self.items = [
                                PersonalList(title: "头部",cellHeight: 112, identifier: PersonalHeaderViewCell.cellIdentifier(),extra: memberData),
                                PersonalList(title: "套餐卡",cellHeight: 71, identifier: PersonalPackageCardViewCell.cellIdentifier()),
                                PersonalList(title: "我的设备",cellHeight: 250, identifier: PersonalDevicesViewCell.cellIdentifier()),
                                PersonalList(title: "我的资产",cellHeight: 120, identifier: PersonalAssetsViewCell.cellIdentifier(),extra: body),
                                PersonalList(title: "我的里程",cellHeight: 120, identifier: PersonalMileageViewCell.cellIdentifier(),extra: nil),
                                PersonalList(title: "其他服务",cellHeight: 180, identifier: PersonalOthersViewCell.cellIdentifier(),items: [
                                    PersonalListItem(title: "我的订单",icon: "order"),
                                    PersonalListItem(title: "购买套餐",icon: "buy"),
                                    PersonalListItem(title: "电池寄存",icon: "post"),
                                    PersonalListItem(title: "卡仓取电",icon: "fetch_b"),
                                    PersonalListItem(title: "邀请有礼",icon: "invite"),
                                    PersonalListItem(title: "用户反馈",icon:"remark"),
                                    PersonalListItem(title: "用户指南",icon: "guide"),
                                    PersonalListItem(title: "消息通知",icon: "message"),
                                    PersonalListItem(title: "常见问题",icon:"qa"),
                                    PersonalListItem(title: "领券中心",icon: "coupon")
                                ])]
                        
                    self.getData(mileageUrl, param: [:], isLoading: false) { responseObject in
                        if let mileBody = (responseObject as? [String: Any])?["body"] as? [String: Any] {
                            if let index = self.items.firstIndex(where: { personal in
                                return personal.title == "我的里程"
                            }){
                                var temp = self.items
                                temp[index] = PersonalList(title: "我的里程",cellHeight: 120, identifier: PersonalMileageViewCell.cellIdentifier(),extra: mileBody)
                                self.items = temp
                            }
                            
                        }
                    } error: { error in
                        self.showError(withStatus: error.localizedDescription)
                    }
                    }else{
                        self.items = [
                            PersonalList(title: "头部",cellHeight: 112, identifier: PersonalHeaderViewCell.cellIdentifier(),extra: memberData),
                            PersonalList(title: "立即实名",cellHeight: 55, identifier: AuthorityViewCell.cellIdentifier()),
                            PersonalList(title: "我的设备",cellHeight: 250, identifier: PersonalDevicesViewCell.cellIdentifier()),
                            PersonalList(title: "我的资产",cellHeight: 120, identifier: PersonalAssetsViewCell.cellIdentifier(),extra: body),
                            PersonalList(title: "我的里程",cellHeight: 120, identifier: PersonalMileageViewCell.cellIdentifier()),
                            PersonalList(title: "其他服务",cellHeight: 180, identifier: PersonalOthersViewCell.cellIdentifier(),items: [
                                PersonalListItem(title: "我的订单",icon: "order"),
                                PersonalListItem(title: "购买套餐",icon: "buy"),
                                PersonalListItem(title: "电池寄存",icon: "post"),
                                PersonalListItem(title: "卡仓取电",icon: "fetch_b"),
                                PersonalListItem(title: "邀请有礼",icon: "invite"),
                                PersonalListItem(title: "用户反馈",icon:"remark"),
                                PersonalListItem(title: "用户指南",icon: "guide"),
                                PersonalListItem(title: "消息通知",icon: "message"),
                                PersonalListItem(title: "常见问题",icon:"qa"),
                                PersonalListItem(title: "领券中心",icon: "coupon")
                            ])]
                    }
                    
                }
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
        
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMemberData()
        
    }
    deinit {
    }
    
}

// MARK: - Setup
private extension PersonalViewController {
    
    private func setupNavbar() {
        self.title = "我的"
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor.white
        let bgView = PersonalViewBackgroundView(frame: self.view.bounds)
        view.addSubview(bgView)
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
extension PersonalViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        guard let identifier = item.identifier else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let headerCell = cell as? PersonalHeaderViewCell{
            headerCell.element = item
            headerCell.headerImageBlock = { tap in
                let personalInfoViewController = PersonalInfoViewController()
                self.navigationController?.pushViewController(personalInfoViewController, animated: true)
                
                
            }
            headerCell.settingsAction = {button in
                let settings = SettingsViewController()
                settings.hasLogoutBlock = {
                    self.tabBarController?.selectedIndex = 0
                }
                self.navigationController?.pushViewController(settings, animated: true)
            }
        }else if let contentCell = cell as? PersonalDevicesViewCell{
            contentCell.titleLabel.text = item.title
            contentCell.deviceTuple = (HFKeyedArchiverTool.batteryDataList().first,HFKeyedArchiverTool.bikeDetailList().first)
            contentCell.batteryDetailAction = { sender in
                //电池详情
                let detailVC = BatteryDetailViewController()
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            contentCell.batteryRentAction = { sender in
                //扫码租电
                HFScanTool.shared.showScanController(from: self)

            }
            contentCell.batteryRenewAction = { sender in
                //电池续租
                let batteryRenewViewController = BatteryRenewViewController()
                self.navigationController?.pushViewController(batteryRenewViewController, animated: true)
            }
            contentCell.bikeDetailAction = { sender in
                //电池详情
                let detailVC = BikeDetailViewController()
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            contentCell.bikeRentAction = { sender in
                //扫码租车
                HFScanTool.shared.showScanController(from: self)
            }
            contentCell.bikeRenewAction = { sender in
                //电车续租
                let bikeRenewViewController = BikeRenewViewController()
                self.navigationController?.pushViewController(bikeRenewViewController, animated: true)
            }
        }else if let contentCell = cell as? PersonalAssetsViewCell{
            contentCell.titleLabel.text = item.title
            let depositData = HFDepositData.mj_object(withKeyValues: (item.extra as? [String:Any])?["depositData"])
            let couponData = HFCouponCountData.mj_object(withKeyValues: (item.extra as? [String:Any])?["couponData"])
            contentCell.depositData = depositData
            contentCell.payVoucherCount = (item.extra as? [String:Any])?["payVoucherCount"] as? Int
            contentCell.couponData = couponData
            contentCell.packageCardBlock = { tap in
                let allPackageCardViewController = AllPackageCardViewController()
                self.navigationController?.pushViewController(allPackageCardViewController, animated: true)
            }
            contentCell.depositBlock = { tap in
                let depositManagementViewController = DepositManagementViewController()
                depositManagementViewController.depositData = depositData
                self.navigationController?.pushViewController(depositManagementViewController, animated: true)
            }
            contentCell.couponBlock = { tap in
                let allCouponViewController = AllCouponViewController()
                self.navigationController?.pushViewController(allCouponViewController, animated: true)
            }
        }else if let contentCell = cell as? PersonalMileageViewCell{
            contentCell.titleLabel.text = item.title
            contentCell.extra = item.extra as? [String:Any]
        }else if let contentCell = cell as? PersonalOthersViewCell{
            contentCell.didSelectItemAtBlock = { collectionView,indexPath in
                if indexPath.item == 0 {
                    let allOrderVC = AllOrderViewController()
                    self.navigationController?.pushViewController(allOrderVC, animated: true)
                }else if indexPath.item == 1{
                    let vc=PackageCardChooseServiceViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if indexPath.item == 2{
                    self.showWindowInfo(withStatus: "暂未开放")
                }else if indexPath.item == 3{
                    let scanVC = HFScanViewController()
                    scanVC.resultBlock = { result in
                        if let resultString = result.strScanned{
                            if resultString.contains("https://www.coreforce.cn/c") {
                                let resultArray = resultString.components(separatedBy: "n=")
                                if let typeName = resultArray.last {
                                    self.postData(gridOpenUrl, param: ["cabinetNumber":typeName], isLoading: true) { responseObject in
                                        self.showWindowInfo(withStatus: "请取出电池，关闭舱门，重新扫码换电")
                                        scanVC.navigationController?.popViewController(animated: true)
                                    } error: { error in
                                        self.showError(withStatus: error.localizedDescription)
                                    }

                                }
                            } else {
                                self.showError(withStatus: "请扫描对应运营商电池柜二维码")
                            }
                        }
                        
                    }
                    self.navigationController?.pushViewController(scanVC, animated: true)
                }else if indexPath.item == 4{
                    let inviteVC = InviteCodeViewController()
                    self.navigationController?.pushViewController(inviteVC, animated: true)
                    
                }else if indexPath.item == 5{
                    let userFeedbackVC = UserFeedbackViewController()
                    self.navigationController?.pushViewController(userFeedbackVC, animated: true)
                    
                }else if indexPath.item == 6{
                   let userGuideVC = UserGuideViewController()
                    self.navigationController?.pushViewController(userGuideVC, animated: true)

                }else if indexPath.item == 7{
                    let messageListVC = MessageListViewController()
                    self.navigationController?.pushViewController(messageListVC, animated: true)

                }else if indexPath.item == 8{
                    let customerVC = CustomerServiceViewController()
                    self.navigationController?.pushViewController(customerVC, animated: true)
                }else if indexPath.item == 9{
                    let allCouponViewController = AllCouponViewController()
                    self.navigationController?.pushViewController(allCouponViewController, animated: true)
                }
            }
            contentCell.titleLabel.text = item.title
            contentCell.items = item.items ?? []
        }else if let contentCell = cell as? AuthorityViewCell{
            contentCell.sureAction = { sender in
                let realNameAuthVC = RealNameAuthViewController()
                self.navigationController?.pushViewController(realNameAuthVC, animated: true)
            }
        }
        
        return cell
        
        
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        let 5item = self.items[indexPath.row]
    //        return item.cellHeight ?? 0
    //    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        if item.title == "套餐卡"{
            let vc=PackageCardChooseServiceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
}

// MARK: - Request
private extension PersonalViewController {
    
}

// MARK: - Action
@objc private extension PersonalViewController {
    
}

// MARK: - Private
private extension PersonalViewController {
    
}
