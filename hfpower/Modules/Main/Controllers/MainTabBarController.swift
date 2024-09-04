//
//  MainTabBarController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {
    
    // MARK: - Accessor
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(scanTypeChanged(_:)), name: .scanTypeChanged, object: nil)
        
        self.didHijackHandler = {
            [weak self] tabbarController, viewController, index in
            let fb =   UIImpactFeedbackGenerator(style: .heavy)
            fb.impactOccurred()
            if  AccountManager.shared.phoneNum == nil{
                if self?.isViewLoaded == true{
                    let loginVC = LoginViewController()
                    let nav = UINavigationController(rootViewController: loginVC)
                    nav.modalPresentationStyle = .fullScreen
                    nav.modalTransitionStyle = .coverVertical
                    self?.present(nav, animated: true, completion: {
                        self?.showWindowError(withStatus: "请登录~~")
                        
                    })
                }
                
                return
            }
            if  AccountManager.shared.isAuth != 1{
                if self?.isViewLoaded == true{
                    let realNameAuthVC = RealNameAuthViewController()
                    let nav = UINavigationController(rootViewController: realNameAuthVC)
                    nav.modalPresentationStyle = .fullScreen
                    nav.modalTransitionStyle = .coverVertical
                    self?.present(nav, animated: true, completion: {
                        self?.showWindowError(withStatus: "请实名认证~~")
                        
                    })
                }
                
                return
            }
            let scanVC = HFScanViewController()
            scanVC.resultBlock = { result in
                guard let resultString = result.strScanned else {return}
                if resultString.contains("www.coreforce.cn") {
                    // 扫码获得类型
                    guard let startRange = resultString.range(of: "cn/"),
                          let endRange = resultString.range(of: "?n") else { return }
                    
                    let range = startRange.upperBound..<endRange.lowerBound
                    let resultStr = String(resultString[range])
                    
                    // 获得 n= 型号字符串
                    let resultArray = resultString.components(separatedBy: "n=")
                    guard let typeName = resultArray.last else { return }
                    
                    if resultStr == "b" {//电池
                        if let firstBatteryNumber = MainManager.shared.batteryDetail?.number, firstBatteryNumber == typeName {
                            let batteryVC = BatteryDetailViewController()
                            self?.navigationController?.pushViewController(batteryVC, animated: true)
                            return
                        } else if let firstBatteryNumber = MainManager.shared.batteryDetail?.number, firstBatteryNumber != typeName {
                            self?.showError(withStatus: "已租电池，请扫柜换电")
                            return
                        }
                    } else if resultStr == "c" {//电柜
                        if let battery = MainManager.shared.batteryDetail{//换电
                            self?.batteryReplacement(id: battery.id?.intValue, number: typeName)
                        }else{//新租
                            self?.rentBattery(number: typeName)
                        }
                    }else if resultStr == "l" {//机车
                        
                    }else{
                        self?.showError(withStatus: "二维码错误，请扫核蜂换电有关二维码进行扫码")
                    }
                }
            }
            self?.navigationController?.pushViewController(scanVC, animated: true)

            
        }
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    func rentBattery(number:String?){
        NetworkService<BusinessAPI,CabinetDetailResponse>().request(.cabinet(id: nil, number: number)) { result in
            switch result {
            case .success(let response):
                if  let payingOrderId = response?.payingOrderId{
                    self.showAlertController(titleText: "温馨提示", messageText: "您有订单尚未完成支付，取消订单将会返还已使用优惠券到您账户，是否取消？") {
                        self.presentedViewController?.dismiss(animated: true)
                        let orderDetailVC = OrderDetailViewController()
                        orderDetailVC.element = OrderList(id: payingOrderId)
                        self.navigationController?.pushViewController(orderDetailVC, animated: true)
                    } cancelAction: {
                        NetworkService<BusinessAPI,BlankResponse>().request(.orderCancel(orderId: payingOrderId)) { result in
                            switch result {
                            case .success:
                                self.showSuccess(withStatus: "取消成功")
                            case .failure(let failure):
                                self.showError(withStatus: failure.localizedDescription)
                            }
                        }
                    }
                }else{
                    self.showAlertController(titleText: "温馨提示", messageText: "您确定要电池柜租电？") {

                    } cancelAction: {

                    }
                }

            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
            }
        }
    }
    func batteryReplacement(id:Int?,number:String?){
        NetworkService<BusinessAPI,CabinetScanResponse>().request(.cabinetScan(cabinetNumber: number, batteryId: id)) { result in
            switch result {
            case .success(let response):
                
                if response?.status == 1{
                    self.showAlertController(titleText: "提示", messageText: "柜中电池电量低于更换电池是否替换") {
                        let batteryReplacementViewController = BatteryReplacementViewController()
                        batteryReplacementViewController.opNo = response?.opNo ?? ""
                        self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                    }cancelAction: {
                        
                    }
                }else if response?.status == 2{
                    let batteryReplacementViewController = BatteryReplacementViewController()
                    batteryReplacementViewController.opNo = response?.opNo ?? ""
                    self.navigationController?.pushViewController(batteryReplacementViewController, animated: true)
                }
            case .failure(let failure):
                self.showError(withStatus: failure.localizedDescription)

            }
        }
    }
    func addRoundedCorners() {
        
        tabBar.layer.borderWidth = 0.5 // Adjust the border width as needed
        tabBar.layer.borderColor = UIColor.clear.cgColor // Set border color to clear
        tabBar.shadowImage = UIColor.clear.toImage()
        tabBar.backgroundImage = UIColor.clear.toImage()
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(origin: tabBar.bounds.origin, size: CGSize(width: tabBar.bounds.size.width, height: tabBar.bounds.size.height + 40)),
                                       byRoundingCorners: [.topLeft, .topRight],
                                       cornerRadii: CGSize(width: 8, height: 8)).cgPath
        let barLeftArc = CAShapeLayer()
        barLeftArc.contents = UIImage(named: "bar_left_arc")?.cgImage
        barLeftArc.frame = CGRect(x: tabBar.bounds.midX - 49 - 64 + 30, y: tabBar.bounds.minY - 24 + 12, width: 64, height: 24)
        let barRightArc = CAShapeLayer()
        barRightArc.contents = UIImage(named: "bar_right_arc")?.cgImage
        barRightArc.frame = CGRect(x: tabBar.bounds.midX + 49 - 30, y: tabBar.bounds.minY - 24 + 12, width: 64, height: 24)
        shapeLayer.addSublayer(barLeftArc)
        shapeLayer.addSublayer(barRightArc)
        
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - Setup
private extension MainTabBarController {
    
    private func setupNavbar() {
        addRoundedCorners()
        
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension MainTabBarController {
    class func defaultMainController(_ centerItemType:MainScanItemType = .battery_rent) -> UIViewController {
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(title: "地图", image: UIImage(named: "map"), selectedImage: UIImage(named: "map"))
        let center = UIViewController()
        let mainScanItemView = MainScanItemView()
        mainScanItemView.mainScanItemType = .battery_rent
        center.tabBarItem = ESTabBarItem(mainScanItemView)
        
        //        let connection = UINavigationController(rootViewController: ConnectionViewController())
        //        let message = UINavigationController(rootViewController: MessageViewController())
        let personal = PersonalViewController()
        personal.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "my"), selectedImage: UIImage(named: "my"))
        let viewControllers = [home,center, /*connection, message,*/ personal]
        let mainTabBarController = MainTabBarController()
        mainTabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        
        mainTabBarController.viewControllers = viewControllers
        mainTabBarController.title = "Main"
        let nav = UINavigationController.init(rootViewController: mainTabBarController)
        return nav
    }
    
}

// MARK: - Request
private extension MainTabBarController {
    
}

// MARK: - Action
@objc private extension MainTabBarController {
    @objc func scanTypeChanged(_ notification:Notification){
        let type = MainScanItemType(rawValue: MainManager.shared.type?.intValue ?? 0)
        if let tabBarItem = self.viewControllers?[1].tabBarItem as? ESTabBarItem,let itemView = tabBarItem.contentView as? MainScanItemView{
            itemView.mainScanItemType = type
            
        }
    }
}

// MARK: - Private
private extension MainTabBarController {
    
}
