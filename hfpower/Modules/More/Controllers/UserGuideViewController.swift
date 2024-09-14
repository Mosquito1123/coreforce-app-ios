//
//  UserGuideViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

import UIKit
import WebKit

class UserGuideViewController: BaseViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "用户指南"
        setupWebView()
        loadWebPage()
    }
    
    private func setupWebView() {
        // 初始化并配置 WKWebView
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // 将 WebView 添加到视图中
        view.addSubview(webView)
        
        // 使用自动布局约束来配置 WebView 的大小和位置
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWebPage() {
        // 加载网页
        if let url = URL(string: "http://coreforce.cn/product/index/116") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // WKNavigationDelegate 方法，可以在页面加载完成后执行额外操作
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载完成")
    }
}
