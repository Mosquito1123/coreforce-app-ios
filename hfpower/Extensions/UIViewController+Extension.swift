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
 
    
    func presentGetCouponController(textAction:((String) -> Void)?,buttonAction:(()->Void)?,cancelBlock:((AlertAction)->Void)? = nil,sureBlock:((AlertAction,String) -> Void)? = nil){
        let getCouponAlertView = GetCouponAlertView()
        getCouponAlertView.commonInputView.textField.addTextChangedAction { text in
            textAction?(text ?? "")
        }
        getCouponAlertView.submitButton.addAction(for: .touchUpInside) {
            buttonAction?()
        }
        getCouponAlertView.translatesAutoresizingMaskIntoConstraints = false
        let alert = AlertController(attributedTitle: NSAttributedString(string: "获取优惠券",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba: 0x333333FF)]), attributedMessage: nil)
        alert.visualStyle.width = UIScreen.main.bounds.size.width - 64
        alert.visualStyle.backgroundColor = .white
        alert.visualStyle.verticalElementSpacing = 12
        alert.contentView.addSubview(getCouponAlertView)
        
        getCouponAlertView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        getCouponAlertView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        
        getCouponAlertView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        getCouponAlertView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        
        
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "取消",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x333333FF) ]), style: .normal, handler: cancelBlock))
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "提取",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x447AFEFF) ]), style: .normal, handler: { action in
            sureBlock?(action,getCouponAlertView.commonInputView.textField.text ?? "")
        }))
        alert.present()
    }
    func presentInputNumberAlertController(textAction:((String) -> Void)?,cancelBlock:((AlertAction)->Void)? = nil,sureBlock:((AlertAction,String) -> Void)? = nil){
        let inputNumberAlertView = InputNumberAlertView()
        inputNumberAlertView.commonInputView.textField.addTextChangedAction { text in
            textAction?(text ?? "")
        }
        
        inputNumberAlertView.translatesAutoresizingMaskIntoConstraints = false
        let alert = AlertController(attributedTitle: NSAttributedString(string: "输码",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba: 0x333333FF)]), attributedMessage: nil)
        alert.visualStyle.width = UIScreen.main.bounds.size.width - 64
        alert.visualStyle.backgroundColor = .white
        alert.visualStyle.verticalElementSpacing = 12
        alert.contentView.addSubview(inputNumberAlertView)
        
        inputNumberAlertView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        inputNumberAlertView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        
        inputNumberAlertView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        inputNumberAlertView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        
        
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "取消",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x333333FF) ]), style: .normal, handler: cancelBlock))
        alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "确定",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba:0x447AFEFF) ]), style: .normal, handler: { action in
            sureBlock?(action,inputNumberAlertView.commonInputView.textField.text ?? "")

        }))
        alert.present()
    }
    func showAlertController(titleText: String, messageText: String, okAction: @escaping () -> Void, isCancelAlert: Bool = false, cancelAction: @escaping () -> Void = {}) {
        // Create attributed text
        let title = NSAttributedString(string: titleText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16,weight: .medium),.foregroundColor:UIColor.black])
        let p = NSMutableParagraphStyle()
        p.alignment = .center
        let message = NSAttributedString(string: messageText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),.foregroundColor:UIColor(rgba: 0x1D2129FF),.paragraphStyle:p])
        let alert = AlertController(attributedTitle: title, attributedMessage: message, preferredStyle: .alert)
        
        if isCancelAlert {
            let cancelAction = AlertAction(title: "取消", style: .normal) { _ in
                cancelAction()
            }
            alert.addAction(cancelAction)
        }
        let okAction = AlertAction(title: "确定", style: .preferred) { alertAction in
            okAction()
        }
        alert.addAction(okAction)
        
       
        
        alert.present()
    }

    func presentCustomAlert(withImage imageName: String, titleText: String, messageText: String,cancel cancelTitle:String,_ cancelBlock:(@escaping ()->Void),sure sureTitle:String,_ sureBlock:(@escaping () -> Void)) {
        // Create a mutable attributed string
        let attributedString = NSMutableAttributedString()
        
        // Create an NSTextAttachment with an image
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        // Set the bounds for the attachment (width, height, x offset, y offset)
        let imageWidth: CGFloat = 20 // Desired width
        let imageHeight: CGFloat = 20 // Desired height
        let yOffset: CGFloat = -5 // Vertical offset

        imageAttachment.bounds = CGRect(x: 0, y: yOffset, width: imageWidth, height: imageHeight)
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
        alert.visualStyle.width = (311.0/375.0)
        // Add buttons
        let cancelButton = UIButton(type: .custom)
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderColor = UIColor(rgba:0xC9CDD4FF).cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.setTitle(cancelTitle, for: .normal)
        cancelButton.setTitle(cancelTitle, for: .highlighted)
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
        sureButton.setTitle(sureTitle, for: .normal)
        sureButton.setTitle(sureTitle, for: .highlighted)
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
    func showActionSheet(_ iconNames:[String],_ methods:[String],_ cancelTitle:String,_ handler:HandlerAction?){
        var list = [NSAttributedString]()
        for i in 0..<methods.count{
            let attributedString = NSMutableAttributedString()
            // Create an NSTextAttachment with an image
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: iconNames[i])
            // Set the bounds for the attachment (width, height, x offset, y offset)
            let imageWidth: CGFloat = 20 // Desired width
            let imageHeight: CGFloat = 20 // Desired height
            let yOffset: CGFloat = -5 // Vertical offset
            
            imageAttachment.bounds = CGRect(x: 0, y: yOffset, width: imageWidth, height: imageHeight)
            let imageString = NSAttributedString(attachment: imageAttachment)
            
            // Create attributed text
            let methodTitle = NSAttributedString(string: methods[i], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba: 0x333333FF)])
            attributedString.append(imageString)
            attributedString.append(NSAttributedString(string: " ")) // Line break
            attributedString.append(methodTitle)
            attributedString.append(NSAttributedString(string: " ")) // Line break
            list.append(attributedString)
        }
        var cancelList = [NSAttributedString]()
        let cancelATitle = NSAttributedString(string: cancelTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(rgba: 0x1D2129FF)])
        cancelList.append(cancelATitle)

        
        let actionSheet = CustomActionSheetViewController()
        actionSheet.items = [list,cancelList]
        actionSheet.handler = handler
        let nav = UINavigationController(rootViewController: actionSheet)
        nav.modalPresentationStyle = .custom
        let delegate =  CustomTransitioningDelegate()
        nav.transitioningDelegate = delegate
        
        if #available(iOS 13.0, *) {
            nav.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        
        self.present(nav, animated: false) {
            
        }
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

class ReturnBatteryAlertView: UIView {

    // MARK: - Accessor
    var code:String?{
        didSet{
            guard let image =  generateQRCode(for: code ?? "", size: 115) else {return}
            self.iconImageView.image = image
        }
    }
    func generateQRCode(for code: String, size: CGFloat) -> UIImage? {
        // 创建滤镜
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        // 设置输入数据
        let data = code.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        // 设置纠错级别 (可选)
        // filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        // 获取输出图像
        guard let ciImage = filter.outputImage else {
            return nil
        }
        
        // 将 CIImage 转换为 UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        let uiImage = UIImage(cgImage: cgImage)
        
        //调整大小 (可选)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), false, 0.0)
        uiImage.draw(in: CGRect(x: 0, y: 0, width: size, height: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    // MARK: - Subviews
    lazy var titleLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "或扫描柜子归还电池"
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var titleLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "请确认电池与换电柜是否连接良好,或点击确定后稍后确认\n\n或拨打客服电话"
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.setImage(UIImage(named: "scan"), for: .highlighted)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension ReturnBatteryAlertView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.titleLabel1)
        self.addSubview(self.titleLabel2)
        self.addSubview(self.iconImageView)
        self.addSubview(self.submitButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10.5),
            iconImageView.bottomAnchor.constraint(equalTo: titleLabel1.topAnchor,constant: -20.5),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 115),
            iconImageView.widthAnchor.constraint(equalToConstant: 115),
            titleLabel1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel1.bottomAnchor.constraint(equalTo: submitButton.topAnchor,constant: -10),
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            submitButton.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -40),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            submitButton.heightAnchor.constraint(equalToConstant: 40),



        ])
        
    }
    
}

// MARK: - Public
extension ReturnBatteryAlertView {
    
}

// MARK: - Action
@objc private extension ReturnBatteryAlertView {
    
}

// MARK: - Private
private extension ReturnBatteryAlertView {
    
}
class GetCouponAlertView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "输入优惠券券码"
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var titleLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "或扫码优惠券二维码"
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.setImage(UIImage(named: "scan"), for: .highlighted)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var commonInputView: CommonInputView = {
        let view = CommonInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension GetCouponAlertView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.titleLabel1)
        self.addSubview(self.titleLabel2)
        self.addSubview(self.commonInputView)
        self.addSubview(self.submitButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            titleLabel1.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            titleLabel1.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            titleLabel1.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            titleLabel1.bottomAnchor.constraint(equalTo: commonInputView.topAnchor,constant: -12),
            commonInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            commonInputView.bottomAnchor.constraint(equalTo: titleLabel2.topAnchor,constant: -22),
            commonInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            commonInputView.heightAnchor.constraint(equalToConstant: 44),
            titleLabel2.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            titleLabel2.bottomAnchor.constraint(equalTo: submitButton.topAnchor,constant: -12),
            titleLabel2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            submitButton.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -40),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            submitButton.heightAnchor.constraint(equalToConstant: 40),



        ])
        
    }
    
}

// MARK: - Public
extension GetCouponAlertView {
    
}

// MARK: - Action
@objc private extension GetCouponAlertView {
    
}

// MARK: - Private
private extension GetCouponAlertView {
    
}

class InputNumberAlertView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "请输入电池或电柜上二维码旁边的字母数字编码"
        label.textColor = UIColor(rgba:0x4D4D4DFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var commonInputView: CommonInputView = {
        let view = CommonInputView()
        view.placeholder = "请输入二维码编码"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension InputNumberAlertView {
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.addSubview(self.commonInputView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: commonInputView.topAnchor,constant: -12),
            commonInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 24),
            commonInputView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -22),
            commonInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -24),
            commonInputView.heightAnchor.constraint(equalToConstant: 44),
            



        ])
        
    }
    
}

// MARK: - Public
extension InputNumberAlertView {
    
}

// MARK: - Action
@objc private extension InputNumberAlertView {
    
}

// MARK: - Private
private extension InputNumberAlertView {
    
}
