//
//  UIViewController+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import UIKit
import SDCAlertView
import MapKit
extension UIViewController{
    func mapNavigation(lat: Double, lng: Double, address: String?, currentController: UIViewController?) {
        let urlScheme = "hefenghuandian://" // 设置本APPurlScheme 可修改
        let appName = "tie.battery.qi" // 设置APP名称 可修改
        
        // 设置目的地的经纬度结构体
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        var destinationName = "目的地"
        if let address = address, !address.isEmpty {
            destinationName = address
        }
        
        let alert = AlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Apple Maps
        if let appleMapsURL = URL(string: "http://maps.apple.com/"), UIApplication.shared.canOpenURL(appleMapsURL) {
            let action = AlertAction(title: "苹果地图", style: .normal) { _ in
                let currentLocation = MKMapItem.forCurrentLocation()
                let destinationLocation = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
                destinationLocation.name = destinationName
                MKMapItem.openMaps(with: [currentLocation, destinationLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: true])
            }
            alert.addAction(action)
        }
        
        // Baidu Maps
        if let baiduMapsURL = URL(string: "baidumap://"), UIApplication.shared.canOpenURL(baiduMapsURL) {
            let action = AlertAction(title: "百度地图", style: .normal) { _ in
                let baiduStr = "baidumap://map/direction?origin={{我的位置}}&destination=name:\(destinationName)|latlng:\(coordinate.latitude),\(coordinate.longitude)&mode=driving&coord_type=gcj02"
                if let urlString = baiduStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { success in
                        print("百度地图打开完成")
                    })
                }
            }
            alert.addAction(action)
        }
        
        // Gaode Maps
        if let gaodeMapsURL = URL(string: "iosamap://"), UIApplication.shared.canOpenURL(gaodeMapsURL) {
            let action = AlertAction(title: "高德地图", style: .normal) { _ in
                let gaodeStr = "iosamap://path?sourceApplication=\(appName)&backScheme=\(urlScheme)&dlat=\(coordinate.latitude)&dlon=\(coordinate.longitude)&dname=\(destinationName)&dev=0&t=0"
                if let urlString = gaodeStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { success in
                        print("高德地图打开完成")
                    })
                }
            }
            alert.addAction(action)
        }
        
        // 取消
        let cancelAction = AlertAction(title: "取消", style: .preferred, handler: nil)
        alert.addAction(cancelAction)
        
        if let controller = currentController {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    func showPrivacyAlertController(cancelBlock:((AlertAction)->Void)? = nil,sureBlock:((AlertAction) -> Void)? = nil){
        let textView = UITextView()
        textView.backgroundColor = .clear
        let attributedString = NSMutableAttributedString(string: "阅读并同意《核蜂换电隐私政策》和《租赁协议》", attributes: [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor(named: "666666") ?? UIColor.black
        ])
        
        let privacyPolicyRange = (attributedString.string as NSString).range(of: "《核蜂换电隐私政策》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/index.html", range: privacyPolicyRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: privacyPolicyRange)
        
        let rentalAgreementRange = (attributedString.string as NSString).range(of: "《租赁协议》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/member.html", range: rentalAgreementRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: rentalAgreementRange)
        
        textView.attributedText = attributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        let alert = AlertController(attributedTitle: NSAttributedString(string: "隐私政策和租赁协议",attributes: [.font:UIFont.systemFont(ofSize: 15, weight: .medium)]), attributedMessage: nil)
        alert.visualStyle.verticalElementSpacing = 12
        alert.contentView.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        
        textView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "不同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named: "333333") ?? UIColor.blue]), style: .normal, handler: cancelBlock))
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named: "447AFE") ?? UIColor.blue]), style: .normal, handler: sureBlock))
        alert.present()
    }
    /// 获取最底层window
    static func ex_rootWindow() -> UIWindow? {
        var rootWindow: UIWindow? = nil
        if #available(iOS 13, *) {
            rootWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first
        }
        if let _ = rootWindow {}
        else if let w = UIApplication.shared.delegate?.window {
            rootWindow = w
        }
        else if let w = UIApplication.shared.windows.first {
            rootWindow = w
        }
        return rootWindow
    }
    static func ex_presentController() -> UIViewController? {
        var result: UIViewController? = nil
        var rootVC: UIViewController? = nil
        if let v = self.ex_keyWindow()?.rootViewController {
            rootVC = v
        }
        else if let v = self.ex_rootWindow()?.rootViewController {
            rootVC = v
        }
        repeat {
            if let navi = rootVC as? UINavigationController {
                result = navi.visibleViewController
                rootVC = result?.presentedViewController
            }
            else if let tab = rootVC as? UITabBarController {
                result = tab.selectedViewController
                rootVC = result
            }
            else {
                result = rootVC
                rootVC = nil
            }
        } while rootVC != nil
        
        return result
    }
    /// 获取keyWindow
    static func ex_keyWindow() -> UIWindow? {
        var keyWindow: UIWindow? = nil
        if #available(iOS 13, *) {
            keyWindow = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        return keyWindow
    }
    
    
}
