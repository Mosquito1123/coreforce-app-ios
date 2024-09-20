//
//  ChooseBatteryTypeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit
import Tabman
import Pageboy
class ChooseBatteryTypeViewController:BaseViewController{
    public let content = ChooseBatteryTypeContentViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择电池型号"
        addChild(content)
        
        self.view.addSubview(content.view)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            content.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            content.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor) // 示例：设置固定高度
        ])
        
        content.didMove(toParent: self)
    }
}
class ChooseBatteryTypeContentViewController: TabmanViewController {
    
    // MARK: - Accessor
    // initializes on code
    
    
    
    var items: [(menu: HFBatteryTypeInfo, content: UIViewController)] = [HFBatteryTypeInfo()].map {
        let model = $0
        let vc = BatteryTypeListViewController()
        return (menu: model, content: vc)
    }
    
 
    
    
    
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        updateItems()
    }
    func updateItems(){
        let code = CityCodeManager.shared.cityCode ?? "370200"

        var params = [String: Any]()
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()

        self.getData(largeTypeParentUrl, param: params, isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                let parentGroups = body["parentGroups"] as? [[String:Any]]{
                var all = [HFBatteryTypeInfo]()
                let type = HFBatteryTypeInfo()
                type.name = "全部"
                type.id = NSNumber(integerLiteral: -1)
                type.parentId = NSNumber(integerLiteral: -1)
                all.append(type)
                let items = HFBatteryTypeInfo.mj_objectArray(withKeyValuesArray: parentGroups) as? [HFBatteryTypeInfo] ?? []
                all.append(contentsOf: items)
                self.items = all.map {
                    let model = $0
                    let vc = BatteryTypeListViewController()
                    vc.parentId = $0.id.intValue
                    return (menu: model, content: vc)
                }
                self.reloadData()
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    
}

// MARK: - Setup
private extension ChooseBatteryTypeContentViewController {
    
    private func setupNavbar() {
        self.title = "选择电池型号"
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .flat(color: .white)
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentMode = .fit
        bar.layout.alignment = .centerDistributed
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = .clear
        bar.buttons.customize { button in
     
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.font = UIFont.systemFont(ofSize: 15)
            button.tintColor = UIColor(hex:0x666666FF)
            button.selectedTintColor = UIColor(hex:0x3171EFFF)

        }
        // Add to view
        addBar(bar, dataSource: self, at: .top)
        // 如果只有一项，默认选中
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension ChooseBatteryTypeContentViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return items.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return items[index].content
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = items[index].menu.name
        return TMBarItem(title: title)
    }
}
// MARK: - Request
private extension ChooseBatteryTypeContentViewController {
    
}

// MARK: - Action
@objc private extension ChooseBatteryTypeContentViewController {
    @objc func backButtonTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension ChooseBatteryTypeContentViewController {
    
}

class BatteryTypeListViewController:BaseTableViewController<BatteryTypeListViewCell,HFBatteryTypeList>{
    
    
    
    // MARK: - Accessor
    var parentId:Int = -1
    var index = 0
    // MARK: - Subviews
    
    // 懒加载的 TableView
    
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
        if self.parentId != -1{
            params["parentId"] = self.parentId
        }
        self.getData(largeTypeUrl, param: params, isLoading:false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let list = body["list"] as? [[String:Any]]{
                let items = HFBatteryTypeList.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryTypeList] ?? []
                self.items = items

            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? BatteryTypeListViewCell{
            cellx.sureAction = { sender in
                let buyPackageCardVC = BuyPackageCardViewController()
                buyPackageCardVC.batteryType = self.items[indexPath.row]
                self.navigationController?.pushViewController(buyPackageCardVC, animated: true)
            }
            cellx.detailAction = { sender in
                let batteryTypeDetailVC = BatteryTypeDetailViewController()
                batteryTypeDetailVC.batteryType = self.items[indexPath.row]
                self.navigationController?.pushViewController(batteryTypeDetailVC, animated: true)
            }
        }
    }
}

// MARK: - Setup
private extension BatteryTypeListViewController {
    
    private func setupNavbar() {
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF6F6F6FF)
        self.tableView.backgroundColor = UIColor(hex:0xF6F6F6FF)
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
