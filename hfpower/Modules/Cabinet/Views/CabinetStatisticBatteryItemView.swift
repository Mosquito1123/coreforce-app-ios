//
//  CabinetStatisticBatteryItemView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit
class BatteryLevelView: UIView {
    
    var batteryLevel: CGFloat = 0.75 {
        didSet {
            setNeedsDisplay() // 重绘视图
        }
    }
    
    var normalBatteryBackgroundImage: UIImage? {
        didSet {
            setNeedsDisplay() // 重绘视图
        }
    }
    var warningBatteryBackgroundImage: UIImage? {
        didSet {
            setNeedsDisplay() // 重绘视图
        }
    }
    
    var errorBatteryBackgroundImage: UIImage? {
        didSet {
            setNeedsDisplay() // 重绘视图
        }
    }
    
    convenience init(normalImage: UIImage?, warningImage: UIImage?, errorImage: UIImage?){
        self.init()
        self.normalBatteryBackgroundImage = normalImage
        self.warningBatteryBackgroundImage = warningImage
        self.errorBatteryBackgroundImage = errorImage

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear

    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let imagex:UIImage?
        if batteryLevel >= 0.8 {
            imagex = normalBatteryBackgroundImage
        } else if batteryLevel > 0.2 {
            imagex = warningBatteryBackgroundImage
        } else {
            imagex = errorBatteryBackgroundImage
        }
        // 绘制背景图片
        if let image = imagex {
            image.draw(in: rect)
        }
        
        // 绘制电池条
        let batteryWidth = rect.width * batteryLevel
        let batteryBarRect = CGRect(x: 0, y: 0, width: batteryWidth, height: rect.height)
        
        var batteryColor: UIColor
        if batteryLevel >= 0.8 {
            batteryColor = UIColor(named: "22C788") ?? .green
        } else if batteryLevel > 0.2 {
            batteryColor = UIColor(named: "FAAD14") ?? .yellow
        } else {
            batteryColor = UIColor(named: "FF3B30") ?? .red
        }
        
        let batteryPath = UIBezierPath(roundedRect: batteryBarRect, cornerRadius: 3)
        context.setFillColor(batteryColor.cgColor)
        context.addPath(batteryPath.cgPath)
        context.fillPath()
        
        // 绘制电量文字
        let batteryText = "\(Int(batteryLevel * 100))%"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 10, weight: .medium),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1), .strokeColor: batteryColor, .strokeWidth: -3,
                                                         
            .paragraphStyle: paragraphStyle
        ]
        
        let textRect = CGRect(x: 0, y: (rect.height - 14) / 2, width: rect.width, height: 14)
        batteryText.draw(in: textRect, withAttributes: attributes)
    }
    
    func setBatteryLevel(_ level: CGFloat) {
        batteryLevel = max(0, min(level, 1)) // 确保电量在 0 到 1 之间
    }
}






class BatteryTableViewCell: UITableViewCell {
    var batteryLevel:CGFloat = 0{
        didSet{
            batteryLevelView.setBatteryLevel(batteryLevel)
        }
    }
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    var batteryLevelView: BatteryLevelView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        batteryLevelView = BatteryLevelView(normalImage: UIImage(named: "small_battery_outline_normal"), warningImage: UIImage(named: "small_battery_outline_warning"), errorImage: UIImage(named: "small_battery_outline_error"))
        batteryLevelView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(batteryLevelView)
        
        NSLayoutConstraint.activate([
            batteryLevelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            batteryLevelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            batteryLevelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            batteryLevelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            batteryLevelView.heightAnchor.constraint(equalToConstant: 17)
     
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
