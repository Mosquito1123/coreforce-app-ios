//
//  UIColor+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
extension UIColor{
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        // 创建一个图形上下文
        let renderer = UIGraphicsImageRenderer(size: size)
        
        // 使用图形上下文渲染图像
        let image = renderer.image { context in
            // 设置绘图颜色
            context.cgContext.setFillColor(self.cgColor)
            
            // 绘制一个矩形填充整个图形上下文
            context.cgContext.fill(CGRect(origin: .zero, size: size))
        }
        
        return image
    }
    convenience init(hex: UInt32) {
           let red = CGFloat((hex >> 24) & 0xFF) / 255.0
           let green = CGFloat((hex >> 16) & 0xFF) / 255.0
           let blue = CGFloat((hex >> 8) & 0xFF) / 255.0
           let alpha = CGFloat(hex & 0xFF) / 255.0
           self.init(red: red, green: green, blue: blue, alpha: alpha)
       }
}
extension UIColor {
    func circularImage(diameter: CGFloat) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let path = UIBezierPath(ovalIn: rect)
        self.setFill() // 使用 self 直接填充当前 UIColor
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
