//
//  BaseViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    // 实现 UIGestureRecognizerDelegate 方法，允许多个手势同时识别
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIScreenEdgePanGestureRecognizer || otherGestureRecognizer is UIScreenEdgePanGestureRecognizer {
            return true
        }
        return false
    }

}

// MARK: - Setup
private extension BaseViewController {
    
    private func setupNavbar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize.init(width: 12, height: 20)), for: .normal)  // 设置自定义图片
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
        appearance.titleTextAttributes = [.foregroundColor: UIColor(rgba: 0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension BaseViewController {
    
}

// MARK: - Request
private extension BaseViewController {
    
}

// MARK: - Action
@objc extension BaseViewController {
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
}
@objc private extension BaseViewController {
}

// MARK: - Private
private extension BaseViewController {
    
}
