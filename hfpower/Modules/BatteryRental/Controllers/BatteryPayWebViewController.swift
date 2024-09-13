//
//  BatteryPayWebViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/13.
//

import UIKit
import WebKit
class BatteryPayWebViewController: BaseViewController,WKNavigationDelegate {
    
    // MARK: - Accessor
    var orderPage:String?
    var renewalPage:String?
    var url: URL?

    // MARK: - Subviews
    var webView: WKWebView!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        // Set the URL based on batteryDataArray condition
        if HFKeyedArchiverTool.batteryDataList().count > 0 {
            self.url = URL(string: renewalPage ?? "")
        } else {
            self.url = URL(string: orderPage ?? "")
        }
        
        // Create and load the URL request
        if let url = self.url {
            let request = URLRequest(url: url)
            webView.navigationDelegate = self
            webView.load(request)
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let url = navigationAction.request.url
            let urlStr = url?.absoluteString.removingPercentEncoding

            if let urlStr = urlStr, urlStr.contains("alipays://platformapi/startapp") {
                UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
}

// MARK: - Setup
private extension BatteryPayWebViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        // Initialize WKWebView and add to view
        webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension BatteryPayWebViewController {
    
}

// MARK: - Request
private extension BatteryPayWebViewController {
    
}

// MARK: - Action
@objc private extension BatteryPayWebViewController {
    
}

// MARK: - Private
private extension BatteryPayWebViewController {
    
}
