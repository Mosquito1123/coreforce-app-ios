//
//  BatteryTypeDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

import UIKit
import WebKit

class BatteryTypeDetailViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var batteryType:HFBatteryTypeList?
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        // Initialize the WKWebView
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        // Generate the HTML content with dynamic parameters
        let htmlString = generateBatteryDetailsHTML(
            self.batteryType
        )
        
        // Load the HTML into the webView
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    private func setupNavbar() {
        self.title = "电池型号详情"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
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
        appearance.shadowImage = UIColor.white.toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex:0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
    // Function to generate HTML string with dynamic parameters
    func generateBatteryDetailsHTML(_ batteryType:HFBatteryTypeList?) -> String {
        return """
        <!DOCTYPE html>
        <html lang="zh-CN">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>电池型号详情</title>
            <style>
                body {
                    font-family: 'PingFang SC', sans-serif;
                    margin: 0;
                    padding: 0;
                    background-color: #f7f7f7;
                }
                .container {
                    max-width: 750px;
                    margin: 0 auto;
                    padding: 15px;
                    background-color: #f7f7f7;
                }
               
                .section-title {
                    font-size: 14px;
                    font-family: PingFangSC-Medium;
                    font-weight: 500;
                    color: #333;
                    margin: 15px 0;
                    padding: 10px;
                    background-color: #f7f7f7;
                }
                .image-wrapper {
                    text-align: center;
                }
                .image-wrapper img {
                    width: 100%;
                    border-radius: 10px;
                }
                .battery-details {
                    background-color: #fff;
                    padding: 10px;
                    border-radius: 20px;
                    margin-bottom: 15px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                }
                .battery-details div {
                    display: flex;
                    justify-content: space-between;
                    align-items: center; /* 垂直对齐 */
                    margin-top: 5px;
                    margin-bottom: 5px;
                    border-bottom: 1px solid rgba(238, 238, 238, 1);
                }
                .battery-details div:last-child {
                    border-bottom: none; /* 去掉最后一项的分割线 */
                }
                .battery-details span {
                    font-size: 14px;
                    font-family: PingFangSC-Regular;
                    color: #666;
                    margin-top: 5px;
                    margin-bottom: 5px;
                }
                .battery-details .highlight {
                    color: #165DFF;
                    background-color: rgba(22, 93, 255, 0.1);
                    padding: 3px 10px;
                    border-radius: 8px;
                    margin-top: 5px;
                    margin-bottom: 10px;
                }
                .battery-description {
                    font-size: 14px;
                    color: #666;
                    line-height: 1.6;
                    margin: 10px 0;
                    padding: 10px;
                    background-color: #fff;
                    border-radius: 20px;
                }
                .battery-range {
                    font-size: 14px;
                    color: #666;
                    background-color: #fff;
                    border-radius: 20px;
                    padding: 10px;
                    margin-bottom: 10px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                }
            </style>
        </head>
        <body>

           

            <div class="container">
                <div class="section-title">电池外观</div>
                <div class="image-wrapper">
                    <img src="https://lanhu.oss-cn-beijing.aliyuncs.com/SketchPng1fb4a837ab3b4d472b73624c21619e41cd57fc2f5fb6c2429dc7293365e47e23" alt="Battery Image">
                </div>

                <div class="battery-details">
                    <div>
                        <span>电池型号</span>
                        <span class="highlight">\(batteryType?.name ?? "")</span>
                    </div>
                    <div>
                        <span>电池尺寸</span>
                        <span>\(batteryType?.enduranceMemo ?? "")</span>
                    </div>
                </div>

                <div class="section-title">电池介绍</div>
                <p class="battery-description">
                    \(batteryType?.batteryMemo ?? "")
                </p>

                <div class="section-title">电池续航</div>
                <div class="battery-range">
                    <div>
                        <span>电池续航</span>
                        <span>\(batteryType?.minMileage ?? 0)km~\(batteryType?.maxMileage ?? 0)km</span>
                    </div>
                    <p>
                        （该续航里程范围仅供参考，需结合实际骑手车辆控制功率、车辆型号、车重、使用环境、温度、驾驶习惯等多种因素，以实际情况为准）
                    </p>
                </div>
            </div>

        </body>
        </html>

        """
    }
}
