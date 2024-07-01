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
    convenience init(rgba: UInt32) {
           let red = CGFloat((rgba >> 24) & 0xFF) / 255.0
           let green = CGFloat((rgba >> 16) & 0xFF) / 255.0
           let blue = CGFloat((rgba >> 8) & 0xFF) / 255.0
           let alpha = CGFloat(rgba & 0xFF) / 255.0
           self.init(red: red, green: green, blue: blue, alpha: alpha)
       }
}
