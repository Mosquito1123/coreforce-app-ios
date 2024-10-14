//
//  CustomerServiceDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

import UIKit
import WebKit
class CustomerServiceDetailViewController: BaseViewController,WKNavigationDelegate {
    
    // MARK: - Accessor
    var element:HFHelpList = HFHelpList(){
        didSet{
            let problemId = element.id // Assuming `obj` is an instance with an `id` property
            let token = HFKeyedArchiverTool.account().accessToken // Assuming you're using UserDefaults for storing the token
            urlString = "\(rootRequest)/tqcp/#/richtext?from=app&problemId=\(problemId)&token=\(token)"
        }
    }
    var webView: WKWebView!
       var urlString: String = "https://www.example.com" // You can set this when initializing
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Initialize WKWebView
           webView = WKWebView(frame: self.view.frame)
           webView.navigationDelegate = self
           self.view.addSubview(webView)
           
           // Load the URL
           if let url = URL(string: urlString) {
               let request = URLRequest(url: url)
               webView.load(request)
           }
       }
       
       // WKNavigationDelegate: Optional, for handling page loads, errors, etc.
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           self.title = element.title
       }
       
       func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           self.showError(withStatus: error.localizedDescription)
       }
       
       // You can add more methods for progress, back/forward actions, etc.
   }
