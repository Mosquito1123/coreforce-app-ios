//
//  BatteryReplacementViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class BatteryReplacementViewController: BaseTableViewController<BatteryReplacementStatusViewCell,BatteryReplacementStatus> {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var bottomView: BatteryReplacementBottomView = {
        let view = BatteryReplacementBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [
            BatteryReplacementStatus(),
            BatteryReplacementStatus(),
            BatteryReplacementStatus()]
        self.presentCustomAlert(withImage: "icon_success", titleText: "支付成功", messageText: "您已租电成功，是否立马开仓取电？", cancel: "取消", {
            
        }, sure: "开仓取电") {
            
        }
       

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavbar()
    }
}

// MARK: - Setup
private extension BatteryReplacementViewController {
    
    private func setupNavbar() {
        self.title = "电池租赁"
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize(width: 12, height: 20)), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        // 设置背景色为白色
        appearance.backgroundImage = UIColor.white.toImage()
        appearance.shadowImage = UIColor(rgba: 0xF5F5F5FF).toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(rgba: 0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        let footerView = BatteryReplacementTableFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
        self.tableView.tableFooterView = footerView
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
extension BatteryReplacementViewController {
    
}

// MARK: - Request
private extension BatteryReplacementViewController {
    
}

// MARK: - Action
@objc private extension BatteryReplacementViewController {
    
}

// MARK: - Private
private extension BatteryReplacementViewController {
    
}
