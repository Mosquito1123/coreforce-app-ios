//
//  BatteryReturnViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

import UIKit

class BatteryReturnViewController: UIViewController {
    
    // MARK: - Accessor
    var code: String?
    var opNo: String?
    // MARK: - Subviews
    lazy var batteryReturnView: HFBatteryReturnView = {
        let view = HFBatteryReturnView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 75, height: self.view.frame.height/2))
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.center.y = self.view.center.y - 40
        view.center.x = self.view.center.x
        
        view.scanCabintBtnAction = {
            let scanVC = HFScanViewController()
            scanVC.resultBlock = { result in
                if let resultString = result.strScanned{
                    if resultString.contains("https://www.coreforce.cn/c") {
                        let resultArray = resultString.components(separatedBy: "n=")
                        if let typeName = resultArray.last {
                            self.postData(cabinetScanReturnUrl, param: ["batteryId": HFKeyedArchiverTool.batteryDataList().first?.id ?? 0, "cabinetNumber": typeName], isLoading: true) { responseObject in
                                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let opNo = body["opNo"] as? String {
                                    self.opNo = opNo
                                    self.batteryReturnView.opNo = opNo
                                }
                            } error: { error in
                                // Handle error if needed
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
        
        view.verifyReturnAction = {
            self.getData(returnCheckUrl, param: ["code": self.code ?? ""], isLoading: true) { responseObject in
                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let returned = body["returned"] as? Bool,returned{
                    
                    HFKeyedArchiverTool.removeBatteryData()
                    self.showAlertController(titleText: "提示", messageText: "已成功归还电池") {
                        // Set the root view controller
                        let nav = UINavigationController(rootViewController: MainTabBarController())
                        UIViewController.ex_keyWindow()?.rootViewController = nav
                    }
                    
                } else {
                    self.showError(withStatus: "未成功归还电池,请稍后重试")
                }
                
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
        }
        
        view.scanVerifyReturnAction = {
            self.getData(cabinetStatusUrl, param: ["opNo": self.opNo ?? ""], isLoading: true) { responseObject in
                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let finish = body["finish"] as? Bool,finish{
                    HFKeyedArchiverTool.removeBatteryData()
                    self.showAlertController(titleText: "提示", messageText: "退电成功请点击确定返回主页") {
                        // Set the root view controller
                        let nav = UINavigationController(rootViewController: MainTabBarController())
                        UIViewController.ex_keyWindow()?.rootViewController = nav
                    }
                    
                } else {
                    self.showError(withStatus: "换电柜暂未发现退租电池信息，请稍后重试")
                }
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
            
            
        }
        
        view.returnAction = {
            self.dismiss(animated: false, completion: nil)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
    }
    func loadData(){
        if let batteryDetail = HFKeyedArchiverTool.batteryDataList().first{
            self.postData(batteryReturnUrl, param: ["batteryId":batteryDetail.id], isLoading: true) { responseObject in
                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let code = body["code"] as? String {
                    self.code = code
                    self.batteryReturnView.code = self.code
                }
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
        }
        

    }
}

// MARK: - Setup
private extension BatteryReturnViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension BatteryReturnViewController {
    
}

// MARK: - Request
private extension BatteryReturnViewController {
    
}

// MARK: - Action
@objc private extension BatteryReturnViewController {
    
}

// MARK: - Private
private extension BatteryReturnViewController {
    
}
