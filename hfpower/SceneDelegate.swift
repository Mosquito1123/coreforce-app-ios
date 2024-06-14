//
//  SceneDelegate.swift
//  hfpower
//
//  Created by 钟离 on 2024/4/10.
//

import UIKit
import IQKeyboardManagerSwift
import LookinServer
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var navigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // 设置窗口的根视图控制器，这里假设你有一个名为MainViewController的视图控制器
//        let mainViewController = LoginViewController() // 确保你有这个视图控制器
//        navigationController = UINavigationController(rootViewController: mainViewController)
        // 程序主界面
        var mainController:UIViewController
        if (!(UserDefaults.standard.bool(forKey: "everLaunched") )) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            mainController = GuideViewController()
                   
        }else{
            mainController = MainTabBarController.defaultMainController()

        }
        
        self.window = window
        // 将窗口的根视图控制器设置为导航控制器
        self.window?.rootViewController = mainController
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        self.window?.overrideUserInterfaceStyle = .light
        DispatchQueue.main.async {
            IQKeyboardManager.shared.enable = true

        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

