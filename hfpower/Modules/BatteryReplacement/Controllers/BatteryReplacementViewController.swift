//
//  BatteryReplacementViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class BatteryReplacementViewController: BaseTableViewController<BatteryReplacementStatusViewCell,BatteryReplacementStatus> {
    
    // MARK: - Accessor
    var opNo:String = ""
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
        
        loadCabinetStatus()
        
        
    }
}

// MARK: - Setup
private extension BatteryReplacementViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.title = "电池租赁"
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)  // 设置自定义图片
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
        let footerView = BatteryReplacementTableFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 280))
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
    @objc func loadCabinetStatus(){
        /*NetworkService<BusinessAPI,CabinetStatusResponse>().request(.cabinetStatus(opNo: self.opNo)) { result in
            switch result {
            case.success(let response):
                if response?.finish == true{//换电请求提交成功
                    
                    if response?.errStatus == "E"{//换电失败，请重新扫码
                        self.items = []

                    }else if response?.errStatus == "F"{//换电完成
                        self.items = []

                    }else if response?.errStatus == "0"{//换电完成
                        self.items = []

                    }else{
                        self.items = []
                    }
                }else{
                    self.perform(#selector(self.loadCabinetStatus), with: nil, afterDelay: 3.0)
                }
            case .failure(let error):
                self.showError(withStatus: error.localizedDescription)
                
                
            }
        }
         */

    }
}

// MARK: - Private
private extension BatteryReplacementViewController {
    
}
