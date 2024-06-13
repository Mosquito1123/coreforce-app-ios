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
    var mainObservation:NSKeyValueObservation?
    var accountObservation:NSKeyValueObservation?
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        accountObservation = AccountManager.shared.observe(\.phoneNum, options: [.initial,.old,.new], changeHandler: { accountManager, change in
            if let newName = change.newValue,let x = newName {
                debugPrint(x)
            }
        })
        mainObservation=MainManager.shared.observe(\.type, options: [.old,.new,.initial], changeHandler: { homeManager, change in
            if let temp = change.newValue,let type = temp {
                let type = MainScanItemType(rawValue: type.intValue)
                if let tabBarItem = self.viewControllers?[1].tabBarItem as? ESTabBarItem,let itemView = tabBarItem.contentView as? MainScanItemView{
                    itemView.mainScanItemType = type
                    
                }
            }
        })
        setupNavbar()
        setupSubviews()
        setupLayout()
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
        mainObservation?.invalidate()
        accountObservation?.invalidate()
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
        mainTabBarController.didHijackHandler = {
            [weak mainTabBarController] tabbarController, viewController, index in
            
            
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
    
}

// MARK: - Private
private extension MainTabBarController {
    
}
