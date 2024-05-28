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
        
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
    
    func addRoundedCorners() {
     
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.layer.cornerRadius = 8
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barTintColor = UIColor.white
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
    class func viewControllers() -> [UINavigationController] {
        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem = ESTabBarItem.init(title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
//        let connection = UINavigationController(rootViewController: ConnectionViewController())
//        let message = UINavigationController(rootViewController: MessageViewController())
        let personal = UINavigationController(rootViewController: PersonalViewController())
        personal.tabBarItem = ESTabBarItem.init(title: "我的", image: UIImage(named: "my"), selectedImage: UIImage(named: "my"))
        let viewControllers = [home, /*connection, message,*/ personal]
        
        return viewControllers
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
