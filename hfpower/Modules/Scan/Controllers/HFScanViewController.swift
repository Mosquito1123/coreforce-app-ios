//
//  HFScanViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/14.
//

import UIKit
import swiftScan
import HMSegmentedControl
class HFScanViewController: LBXScanViewController, UIGestureRecognizerDelegate{
    
    /**
     @brief  扫码区域上方提示文字
     */
    var topTitle: UILabel?
    
    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash: Bool = false
    
    // MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    
    //底部显示的功能项
    var bottomItemsView: UIView?
    
    //    //相册
    //    var btnPhoto: UIButton = UIButton()
    
    //闪光灯
    var btnFlash: UIButton = UIButton()
    
    //    //我的二维码
    //    var btnMyQR: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        self.scanResultDelegate = self
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: true)
        self.scanStyle?.anmiationStyle = .LineMove
        self.scanStyle?.animationImage = UIImage(named: "scan_line")
        self.scanStyle?.colorAngle = .white
        self.scanStyle?.photoframeAngleStyle = .On
        self.scanStyle?.colorRetangleLine = .black.withAlphaComponent(0.5)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawBottomItems()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnFlash.setImagePosition(type: .imageTop, Space: 10)
    }
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result: LBXScanResult in arrayResult {
            if let str = result.strScanned {
                print(str)
                
            }
        }
        
        let result: LBXScanResult = arrayResult[0]
        
        
    }
    
    func drawBottomItems() {
        if (bottomItemsView != nil) {
            
            return
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame: CGRect(x: 0.0, y: yMax-100, width: self.view.frame.size.width, height: 100 ) )
        
        bottomItemsView?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        view.addSubview(bottomItemsView ?? UIView())
        
        let size = CGSize(width: 65, height: 87)
        
        self.btnFlash = UIButton()
        // 获取屏幕宽高
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        // 计算按钮的 frame
        let buttonWidth: CGFloat = 112 // 按钮宽度
        let buttonHeight: CGFloat = 62 // 按钮高度
        let buttonX = (screenWidth - buttonWidth) / 2 // 按钮水平居中
        let buttonY = screenHeight - buttonHeight - 180 // 按钮距离底部 180 pt
        
        btnFlash.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        btnFlash.setImage(UIImage(named: "torch"), for:UIControl.State.normal)
        btnFlash.setImage(UIImage(named: "torch"), for:UIControl.State.selected)
        btnFlash.addTarget(self, action: #selector(HFScanViewController.openOrCloseFlash), for: UIControl.Event.touchUpInside)
        btnFlash.setTitle("轻触开启", for: .normal)
        btnFlash.setTitle("轻触关闭", for: .selected)
        
        
        // 初始化 HMSegmentedControl
        let segmentedControl = HMSegmentedControl(sectionTitles: ["扫码", "蓝牙", "输码"])
        
        // 设置 frame
        segmentedControl.frame = CGRect(x: 68, y: yMax-100, width: self.view.frame.size.width - 68 * 2, height: 50)
        
        // 设置下划线的样式
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.selectionIndicatorHeight = 2.0
        segmentedControl.selectionIndicatorColor = .white
        segmentedControl.selectionStyle = .fullWidthStripe
        
        
        // 设置字体样式
        segmentedControl.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(rgba: 0xA0A0A0FF),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17,weight: .medium)
        ]
        
        
        
        
        
        segmentedControl.backgroundColor = .clear
        view.addSubview(bottomItemsView ?? UIView())
        view.addSubview(segmentedControl)
        view.bringSubviewToFront(segmentedControl)
        view.addSubview(self.btnFlash)
        view.bringSubviewToFront(self.btnFlash)
        if let button = view.viewWithTag(10){
            view.bringSubviewToFront(button)
        }
        
    }
    
    //开关闪光灯
    @objc func openOrCloseFlash() {
        scanObj?.changeTorch()
        
        isOpenedFlash = !isOpenedFlash
        btnFlash.isSelected = !btnFlash.isSelected
        
    }
    
    
    
}
// MARK: - Setup
private extension HFScanViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "scan_back"), for: .normal)
        backButton.setImage(UIImage(named: "scan_back"), for: .highlighted)
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addAction(for: .touchUpInside) {
            self.navigationController?.popViewController(animated: true)
        }
        backButton.tag = 10
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            
        ])
    }
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension HFScanViewController:LBXScanViewControllerDelegate {
    func scanFinished(scanResult: swiftScan.LBXScanResult, error: String?) {
        
    }
    
    
}

// MARK: - Request
private extension HFScanViewController {
    
}

// MARK: - Action
@objc private extension HFScanViewController {
    @objc func myCode() {
        let vc = MyCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Private
private extension HFScanViewController {
    
}
