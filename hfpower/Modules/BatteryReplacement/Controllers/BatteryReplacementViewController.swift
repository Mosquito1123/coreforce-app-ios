//
//  BatteryReplacementViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit
protocol BatteryReplacementViewControllerDelegate{
    func batteryReplacement(id:Int?,number:String?)
}
class BatteryReplacementViewController: BaseTableViewController<BatteryReplacementStatusViewCell,BatteryReplacementStatus> {
    
    // MARK: - Accessor
    var opNo:String = ""
    // MARK: - Subviews
    lazy var bottomView: BatteryReplacementBottomView = {
        let view = BatteryReplacementBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var footerView: BatteryReplacementTableFooterView = {
        let footerView = BatteryReplacementTableFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 280))
        footerView.fetchCellBlock = {sender in
            
            let scanVC = HFScanViewController()
            scanVC.resultBlock = { result in
                if let resultString = result.strScanned{
                    if resultString.contains("https://www.coreforce.cn/c") {
                        let resultArray = resultString.components(separatedBy: "n=")
                        if let typeName = resultArray.last {
                            self.postData(gridOpenUrl, param: ["cabinetNumber":typeName], isLoading: true) { responseObject in
                                self.showWindowInfo(withStatus: "请取出电池，关闭舱门，重新扫码换电")
                                scanVC.navigationController?.popViewController(animated: true)
                            } error: { error in
                                self.showError(withStatus: error.localizedDescription)
                            }

                        }
                    } else {
                        self.showError(withStatus: "请扫描对应运营商电池柜二维码")
                    }
                }
                
            }
            self.navigationController?.pushViewController(scanVC, animated: true)
        }
        return footerView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        
        loadCabinetStatus()
        
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if let cellx = cell as? BatteryReplacementStatusViewCell{
                cellx.topLineView.isHidden = true
            }
        }else if indexPath.row == self.items.count - 1{
            if let cellx = cell as? BatteryReplacementStatusViewCell{
                cellx.bottomLineView.isHidden = true
            }
        }else{
            if let cellx = cell as? BatteryReplacementStatusViewCell{
                cellx.bottomLineView.isHidden = false
                cellx.topLineView.isHidden = false

            }
        }
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
        appearance.shadowImage = UIColor(hex:0xF5F5F5FF).toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        
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
        self.getData(cabinetStatusUrl, param: ["opNo":self.opNo], isLoading: false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let finish = body["finish"] as? Bool,finish{
                if let errStatus = body["errStatus"] as? String{
                    if errStatus == "E"{//换电失败，请重新扫码
                        let batteryStatus1 = BatteryReplacementStatus(id: 1, title: "取走电池", content: "如未正常弹开仓门，请点击【卡仓取电】扫码再次尝试取电", type: 0)
                        let batteryStatus2 = BatteryReplacementStatus(id: 2, title: "关闭仓门", content: "", type: 1)
                        let batteryStatus3 = BatteryReplacementStatus(id: 3, title: "租电完成", content: "", type: 1)


                        self.items = [batteryStatus1, batteryStatus2, batteryStatus3]
                        self.footerView.submitButton.isHidden = false
                    }else if errStatus == "F" || errStatus == "0"{//换电完成
                        let batteryStatus1 = BatteryReplacementStatus(id: 1, title: "取走电池", content: "如未正常弹开仓门，请点击【卡仓取电】扫码再次尝试取电", type: 2)
                        let batteryStatus2 = BatteryReplacementStatus(id: 2, title: "关闭仓门", content: "", type: 2)
                        let batteryStatus3 = BatteryReplacementStatus(id: 3, title: "租电完成", content: "", type: 2)


                        self.items = [batteryStatus1, batteryStatus2, batteryStatus3]
                        self.footerView.submitButton.isHidden = true

                    }else{
                        let batteryStatus1 = BatteryReplacementStatus(id: 1, title: "取走电池", content: "如未正常弹开仓门，请点击【卡仓取电】扫码再次尝试取电", type: 0)
                        let batteryStatus2 = BatteryReplacementStatus(id: 2, title: "关闭仓门", content: "", type: 1)
                        let batteryStatus3 = BatteryReplacementStatus(id: 3, title: "租电完成", content: "", type: 1)


                        self.items = [batteryStatus1, batteryStatus2, batteryStatus3]  
                        self.footerView.submitButton.isHidden = false

                    }
                }else{
                    let batteryStatus1 = BatteryReplacementStatus(id: 1, title: "取走电池", content: "如未正常弹开仓门，请点击【卡仓取电】扫码再次尝试取电", type: 2)
                    let batteryStatus2 = BatteryReplacementStatus(id: 2, title: "关闭仓门", content: "", type: 2)
                    let batteryStatus3 = BatteryReplacementStatus(id: 3, title: "租电完成", content: "", type: 2)


                    self.items = [batteryStatus1, batteryStatus2, batteryStatus3]
                    self.footerView.submitButton.isHidden = true
                }
            }else{
                self.perform(#selector(self.loadCabinetStatus), with: nil, afterDelay: 3.0)
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

        

    }
}

// MARK: - Private
private extension BatteryReplacementViewController {
    
}
