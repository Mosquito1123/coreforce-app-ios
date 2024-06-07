//
//  UIImage+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/7.
//

import UIKit
import CoreImage
extension UIImage {
    func colorized(with color: UIColor) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        let colorFilter = CIFilter(name: "CIConstantColorGenerator")
        let colorCI = CIColor(color: color)
        colorFilter?.setValue(colorCI, forKey: kCIInputColorKey)
        
        guard let colorOutput = colorFilter?.outputImage else { return nil }
        
        let compositeFilter = CIFilter(name: "CISourceAtopCompositing")
        compositeFilter?.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        compositeFilter?.setValue(colorOutput, forKey: kCIInputImageKey)
        let context = CIContext(options: nil)
        guard let outputImage = compositeFilter?.outputImage,
              
              let cgOutput = context.createCGImage(outputImage, from: ciImage.extent) else { return nil }
        
        return UIImage(cgImage: cgOutput)
    }
}
