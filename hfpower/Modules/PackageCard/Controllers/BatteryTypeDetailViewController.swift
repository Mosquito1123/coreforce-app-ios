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
        let accessToken = HFKeyedArchiverTool.account().accessToken
        var photoHTML = """

                        """
        if let photos = batteryType?.photo.components(separatedBy: ",").map({ photo in
            return String.imageURLPath(with: photo)
        }) {
            photoHTML = photos.map({ url in
                return "<img src=\"\(url)\" alt = \"\(url)\">"
            }).joined(separator: "")
        }
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
                /* 样式：设置轮播容器 */
                .carousel {
                    width: 100%; /* 设置轮播图的宽度 */
                    max-width: 100%;
                    height: 180px; /* 高度 */
                    overflow: hidden;
                    position: relative;
                    margin: 0 auto;
                    border-radius: 20px; /* 为整个轮播容器添加圆角 */
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 可选：为容器添加阴影 */
                }

                        
                                /* 设置图片轨道 */
                                .carousel-track {
                                    display: flex;
                                    transition: transform 0.5s ease-in-out;
                                }

                                /* 设置每张图片的样式 */
                                .carousel img {
                                    width: 100%;
                                    height: 100%; /* 图片高度 */
                                    object-fit: cover;
                                }

                                /* 右下角标签的样式 */
                                .carousel-index {
                                    position: absolute;
                                    bottom: 10px;
                                    right: 10px;
                                    background-color: rgba(0, 0, 0, 0.5); /* 半透明的黑色背景 */
                                    color: white;
                                    padding: 5px 10px;
                                    border-radius: 10px; /* 标签边角圆滑 */
                                    font-size: 14px; /* 字体大小 */
                                }
                .battery-details {
                    background-color: #fff;
                    padding: 10px;
                    border-radius: 20px;
                    margin-top: 15px;
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
                    font-family: PingFangSC-Medium;
                    font-weight: 500;
                    color: #333;
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
                <div class="carousel">
                        <div class="carousel-track">
                            <!-- 替换为动态生成的图片 URL -->
                            \(photoHTML)
                            <!-- 更多图片可以继续添加 -->
                        </div>
                        
        <!-- 标签显示当前图片索引 -->
                <div class="carousel-index">1/3</div>
                    </div>

                <div class="battery-details">
                    <div>
                        <span>电池型号</span>
                        <span class="highlight">\(batteryType?.name ?? "")</span>
                    </div>
                </div>
                <div class="battery-details">
                    <div>
                        <span>电池介绍</span>
                        <span></span>
                    </div>
                    <p class="battery-description">
                        \(batteryType?.memo ?? "")
                    </p>
                </div>
                <div class="battery-details">
                        <div>
                            <span>电池续航</span>
                            <span>\(batteryType?.minMileage ?? 0)km~\(batteryType?.maxMileage ?? 0)km</span>
                        </div>
                        <p  class="battery-description">
                            （该续航里程范围仅供参考，需结合实际骑手车辆控制功率、车辆型号、车重、使用环境、温度、驾驶习惯等多种因素，以实际情况为准）
                        </p>
                </div>
        <script>
                const track = document.querySelector('.carousel-track');
                const images = Array.from(track.children);
                const indexLabel = document.querySelector('.carousel-index');
                let currentIndex = 0;
                const imageCount = images.length;
                const autoSlideInterval = 3000; // 自动轮播的间隔时间（毫秒）

                // 更新标签内容
                function updateIndexLabel(index) {
                    indexLabel.textContent = `${index + 1}/${imageCount}`;
                }

                function showImage(index) {
                    const imageWidth = images[0].getBoundingClientRect().width;
                    track.style.transform = `translateX(-${index * imageWidth}px)`;
                    updateIndexLabel(index); // 显示当前图片的索引
                }

                function nextImage() {
                    currentIndex = (currentIndex + 1) % imageCount; // 循环切换到下一张图片
                    showImage(currentIndex);
                }

                // 自动轮播功能
                let autoSlide = setInterval(nextImage, autoSlideInterval);

                // 当鼠标悬停时，暂停自动轮播，移开后继续轮播
                document.querySelector('.carousel').addEventListener('mouseover', () => {
                    clearInterval(autoSlide);
                });

                document.querySelector('.carousel').addEventListener('mouseout', () => {
                    autoSlide = setInterval(nextImage, autoSlideInterval);
                });

                // 初始化标签显示
                updateIndexLabel(currentIndex);
            </script>
        </body>
        </html>

        """
    }
}
