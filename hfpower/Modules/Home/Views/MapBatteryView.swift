//
//  MapBatteryView.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
enum MapBatteryType{
    case normal
    case warning
    case dangerous
}
class MapBatteryView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var batteryView: MapBatteryContentView = {
        let view = MapBatteryContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension MapBatteryView {
    
    private func setupSubviews() {
        addSubview(batteryView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 45),
            self.heightAnchor.constraint(equalToConstant: 79),
            batteryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            batteryView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            batteryView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            batteryView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }
    
}

// MARK: - Public
extension MapBatteryView {
    
}

// MARK: - Action
@objc private extension MapBatteryView {
    
}

// MARK: - Private
private extension MapBatteryView {
    
}

class MapBatteryContentView: UIView {
    var status:Int? = 0{
        didSet{
            setNeedsLayout()
            
        }
    }
    var batteryLevel: CGFloat = 0.1 {
        didSet{
            setNeedsLayout()
        }
    }// 电池电量，范围从0到1
    var batteryLevelFullImage:UIImage? = UIImage(named: "battery_level_full"){
        didSet{
            setNeedsLayout()
        }
    }
    var batteryContentColor:UIColor? = UIColor(named: "22C788"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var errorBatteryContentColor:UIColor? = UIColor(named: "FF3B30"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var warningBatteryContentColor:UIColor? = UIColor(named: "FAAD14"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var batteryBackgroundImage:UIImage? = UIImage(named: "battery_outline"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var errorBatteryBackgroundImage:UIImage? = UIImage(named: "battery_outline_error"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var warningBatteryBackgroundImage:UIImage? = UIImage(named: "battery_outline_warning"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var maskImage:UIImage? = UIImage(named: "battery_outline"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var logoImage:UIImage? = UIImage(named: "battery_small_icon"){
        didSet{
            setNeedsLayout()
            
        }
    }
    var batteryString:NSAttributedString?{
        didSet{
            setNeedsLayout()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
       
        let borderWidth: CGFloat = 0
        let cornerRadius: CGFloat = 4
        let padding: CGFloat = 0
      
//        // 电池外壳
        let batteryFrame = CGRect(x: padding, y: padding, width: rect.width - 2 * padding, height: rect.height - 2 * padding)
       
        let batteryPath = UIBezierPath(roundedRect: batteryFrame, cornerRadius: 0)
        context.setFillColor(UIColor.white.cgColor)
        context.addPath(batteryPath.cgPath)
        context.fillPath()
        if let maskImageRef = maskImage?.cgImage{
            // 保存当前图形上下文状态
            context.saveGState()
            
            // 缩放图形上下文
            context.translateBy(x: 0, y: rect.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            // 绘制内容
            context.clip(to: rect, mask: maskImageRef)
            
            // 恢复之前保存的图形上下文状态
            context.restoreGState()
        }
        if batteryLevel >= 1{
            // 添加满电背景图片
        
            let batteryLevelFullImage = batteryLevelFullImage
            batteryLevelFullImage?.draw(in: rect)
        }else{
            // 添加背景图片
            let xbackgroundImage = status == 2 ? warningBatteryBackgroundImage: errorBatteryBackgroundImage
            let backgroundImage = status == 1 ? batteryBackgroundImage:xbackgroundImage
            backgroundImage?.draw(in: rect)
            
            // 电量
            let batteryLevelFrame = CGRect(x: padding + borderWidth, y: padding + borderWidth + (1 - batteryLevel) * (batteryFrame.height - 2 * borderWidth), width: batteryFrame.width - 2 * borderWidth, height: batteryLevel * (batteryFrame.height - 2 * borderWidth))
            let batteryLevelPath = UIBezierPath(roundedRect: batteryLevelFrame, cornerRadius: cornerRadius - borderWidth)
            //电量颜色
            let xbatteryContentColor = status == 2 ? warningBatteryContentColor: errorBatteryContentColor
            let batteryContentColor = status == 1 ? batteryContentColor:xbatteryContentColor
            context.setFillColor((batteryContentColor ?? UIColor.black).cgColor)
            context.addPath(batteryLevelPath.cgPath)
            context.fillPath()
        }
        
        
       
        let percentageString = String(format: "%.f%%", batteryLevel * 100)

        let attrString = NSMutableAttributedString(string: percentageString)
        let attr: [NSAttributedString.Key : Any]
        if(status == 0){
            attr = [.font: UIFont.systemFont(ofSize: 12,weight: .semibold),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1), .strokeColor: UIColor(red: 1,green: 0.23,blue: 0.19,alpha: 1), .strokeWidth: -2]
        }else{
            attr = [.font: UIFont.systemFont(ofSize: 12,weight: .semibold),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        }
        
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
       let textSize = attrString.size()
        let textRect = CGRect(x: rect.midX - textSize.width/2, y: rect.midY + textSize.height, width: textSize.width, height: textSize.height)
        attrString.draw(in: textRect)
        // 添加背景图片
        if let logoImage = logoImage{
            let logoRect = CGRect(x: rect.midX - logoImage.size.width/2, y: rect.midY - logoImage.size.height/2, width: logoImage.size.width, height: logoImage.size.height)
            logoImage.draw(in: logoRect)
        }
        
    }
}

