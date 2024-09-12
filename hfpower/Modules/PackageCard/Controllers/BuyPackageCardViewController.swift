//
//  BuyPackageCardViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit

class BuyPackageCardViewController: BaseViewController {
    
    // MARK: - Accessor
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
        params["largeTypeId"] = self.batteryType?.id
        self.getData(ourPackageCardUrl, param: params, isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any]{
                self.items = [
                    BuyPackageCard(title: "电池型号",subtitle: self.batteryType?.name, identifier: BatteryTypeViewCell.cellIdentifier(), icon:  "battery_type"),
                    BuyPackageCard(title: "换电不限次套餐",subtitle: self.batteryType?.name, identifier: BuyPackageCardPlansViewCell.cellIdentifier(),items: [PackageCard(type: 0),PackageCard(type: 0)]),
                    BuyPackageCard(title: "已购套餐",subtitle: "299元/30天", identifier: BoughtPlansViewCell.cellIdentifier()),
                    BuyPackageCard(title: "押金服务",subtitle: "", identifier: DepositServiceViewCell.cellIdentifier(),depositServices: [DepositService(),DepositService()]),
                    BuyPackageCard(title: "费用结算",subtitle: "299元/30天", identifier: FeeDetailViewCell.cellIdentifier()),
                    BuyPackageCard(title: "推荐码（选填）",subtitle: "点击输入或扫描二维码", identifier: RecommendViewCell.cellIdentifier()),
                    BuyPackageCard(title: "用户须知",subtitle: "", identifier: UserIntroductionsViewCell.cellIdentifier()),
                    BuyPackageCard(title: "限时特惠",subtitle: "", identifier: LimitedTimePackageCardViewCell.cellIdentifier(),items: [PackageCard(type: 1),PackageCard(type: 1)]),
                    BuyPackageCard(title: "新人专享",subtitle: "", identifier: NewComersPackageCardViewCell.cellIdentifier(),items: [PackageCard(type: 2),PackageCard(type: 2)])
                    
                ]
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
                self.bottomView.model = [PackageCard(),PackageCard()][indexPath.item]
            }
        }else if let cellx = cell as? LimitedTimePackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.bottomView.model = item.items?[indexPath.item]
            }
        }else if let cellx = cell as? NewComersPackageCardViewCell{
            cellx.didSelectItemBlock = {(collectionView,indexPath) in
                self.bottomView.model = item.items?[indexPath.item]
            }
        }
        return cell
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
        }else if item.title == "费用结算"{
            let couponListViewController = CouponListViewController()
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
private extension BuyPackageCardViewController {
    
}

// MARK: - Action
@objc private extension BuyPackageCardViewController {
    
}

// MARK: - Private
private extension BuyPackageCardViewController {
    
}
