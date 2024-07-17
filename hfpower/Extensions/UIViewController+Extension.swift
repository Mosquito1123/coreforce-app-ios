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
            .foregroundColor: UIColor(rgba:0x666666FF)
        ])
        
        let privacyPolicyRange = (attributedString.string as NSString).range(of: "《核蜂换电隐私政策》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/index.html", range: privacyPolicyRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgba:0x3171EFFF) , range: privacyPolicyRange)
        
        let rentalAgreementRange = (attributedString.string as NSString).range(of: "《租赁协议》")
        attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/member.html", range: rentalAgreementRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgba:0x3171EFFF) , range: rentalAgreementRange)
        
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
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "不同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x333333FF) ]), style: .normal, handler: cancelBlock))
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x447AFEFF) ]), style: .normal, handler: sureBlock))
        alert.present()
    }
    func presentCustomAlert(withImage imageName: String, titleText: String, messageText: String,_ cancelBlock:(@escaping ()->Void),_ sureBlock:(@escaping () -> Void)) {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
        // Create an NSTextAttachment with an image
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        // Create attributed text
        let title = NSAttributedString(string: titleText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16,weight: .medium),.foregroundColor:UIColor.black])
        let p = NSMutableParagraphStyle()
        p.alignment = .center
        let message = NSAttributedString(string: messageText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),.foregroundColor:UIColor(rgba: 0x1D2129FF),.paragraphStyle:p])
        
        // Append the text and image to the attributed string
        attributedString.append(imageString)
        attributedString.append(NSAttributedString(string: " ")) // Line break
        attributedString.append(title)
        attributedString.append(NSAttributedString(string: " ")) // Line break
        
        
        // Create the alert
        let alert = AlertController(attributedTitle: attributedString, attributedMessage: message, preferredStyle: .alert)
        alert.visualStyle.width = UIScreen.main.bounds.size.width * (311.0/375.0)
        // Add buttons
        let cancelButton = UIButton(type: .custom)
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderColor = UIColor(rgba:0xC9CDD4FF).cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitle("取消", for: .highlighted)
        cancelButton.setTitleColor(UIColor(rgba: 0x1D2129FF), for: .normal)
        cancelButton.setTitleColor(UIColor(rgba: 0x1D2129FF), for: .highlighted)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        cancelButton.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        cancelButton.addAction(for: .touchUpInside) {
            alert.dismiss()
            cancelBlock()
        }
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        alert.contentView.addSubview(cancelButton)
        let sureButton = UIButton(type: .custom)
        sureButton.layer.cornerRadius = 20
        sureButton.layer.masksToBounds = true
        sureButton.layer.borderColor = UIColor(rgba:0x447AFEFF).cgColor
        sureButton.layer.borderWidth = 1
        sureButton.setTitle("开仓取电", for: .normal)
        sureButton.setTitle("开仓取电", for: .highlighted)
        sureButton.setTitleColor(UIColor.white, for: .normal)
        sureButton.setTitleColor(UIColor.white, for: .highlighted)
        sureButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sureButton.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        sureButton.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        sureButton.addAction(for: .touchUpInside) {
            alert.dismiss()
            sureBlock()
        }
        sureButton.translatesAutoresizingMaskIntoConstraints = false
        alert.contentView.addSubview(sureButton)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor,constant: 32),
            cancelButton.trailingAnchor.constraint(equalTo: sureButton.leadingAnchor,constant: -23),
            sureButton.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor, constant: -32),
            cancelButton.widthAnchor.constraint(equalTo: sureButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            sureButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor, constant: -20),
            sureButton.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: alert.contentView.topAnchor, constant: 20),


        ])
        
        // Present the alert
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
