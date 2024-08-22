//
//  MyViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class PersonalViewController: BaseViewController {
    
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
        loadMemberData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    func loadMemberData(){
        NetworkService<MemberAPI,MemberResponse>().request(.member) { result in
            switch result {
            case.success(let response):
                
                AccountManager.shared.isAuth = NSNumber(integerLiteral: response?.member?.isAuth ?? -1)
                if  AccountManager.shared.isAuth == 1{
                    self.items = [
                        PersonalList(title: "头部",cellHeight: 112, identifier: PersonalHeaderViewCell.cellIdentifier(),extra: response?.member),
                        PersonalList(title: "套餐卡",cellHeight: 71, identifier: PersonalPackageCardViewCell.cellIdentifier()),
                        PersonalList(title: "我的设备",cellHeight: 250, identifier: PersonalDevicesViewCell.cellIdentifier()),
                        PersonalList(title: "我的资产",cellHeight: 120, identifier: PersonalAssetsViewCell.cellIdentifier()),
                        PersonalList(title: "我的里程",cellHeight: 120, identifier: PersonalMileageViewCell.cellIdentifier()),
                        PersonalList(title: "其他服务",cellHeight: 120, identifier: PersonalOthersViewCell.cellIdentifier(),items: [
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
                }else{
                    self.items = [
                        PersonalList(title: "头部",cellHeight: 112, identifier: PersonalHeaderViewCell.cellIdentifier(),extra: response?.member),
                        PersonalList(title: "立即实名",cellHeight: 55, identifier: AuthorityViewCell.cellIdentifier()),
                        PersonalList(title: "我的设备",cellHeight: 250, identifier: PersonalDevicesViewCell.cellIdentifier()),
                        PersonalList(title: "我的资产",cellHeight: 120, identifier: PersonalAssetsViewCell.cellIdentifier()),
                        PersonalList(title: "我的里程",cellHeight: 120, identifier: PersonalMileageViewCell.cellIdentifier()),
                        PersonalList(title: "其他服务",cellHeight: 120, identifier: PersonalOthersViewCell.cellIdentifier(),items: [
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
                
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                
            }
        }
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
            headerCell.settingsAction = {button in
                let settings = SettingsViewController()
                settings.hasLogoutBlock = {
                    self.tabBarController?.selectedIndex = 0
                }
                self.navigationController?.pushViewController(settings, animated: true)
            }
        }else if let contentCell = cell as? PersonalDevicesViewCell{
            contentCell.titleLabel.text = item.title
        }else if let contentCell = cell as? PersonalAssetsViewCell{
            contentCell.titleLabel.text = item.title
            contentCell.packageCardBlock = { tap in
                let allPackageCardViewController = AllPackageCardViewController()
                self.navigationController?.pushViewController(allPackageCardViewController, animated: true)
            }
            contentCell.depositBlock = { tap in
                let depositManagementViewController = DepositManagementViewController()
                self.navigationController?.pushViewController(depositManagementViewController, animated: true)
            }
            contentCell.couponBlock = { tap in
                let allCouponViewController = AllCouponViewController()
                self.navigationController?.pushViewController(allCouponViewController, animated: true)
            }
        }else if let contentCell = cell as? PersonalMileageViewCell{
            contentCell.titleLabel.text = item.title
        }else if let contentCell = cell as? PersonalOthersViewCell{
            contentCell.didSelectItemAtBlock = { collectionView,indexPath in
                if indexPath.item == 0 {
                    let allOrderVC = AllOrderViewController()
                    self.navigationController?.pushViewController(allOrderVC, animated: true)
                }
            }
            contentCell.titleLabel.text = item.title
            contentCell.items = item.items ?? []
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
        }else if item.title == "我的设备"{
            let vc = BatteryReplacementViewController()
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
