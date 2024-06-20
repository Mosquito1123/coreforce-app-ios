//
//  MapRect+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import Foundation
import MapKit
extension MKMapRect {
    func expanded(byFactor factor: Double) -> MKMapRect {
        let width = self.size.width * factor
        let height = self.size.height * factor
        let x = self.origin.x - (width - self.size.width) / 2
        let y = self.origin.y - (height - self.size.height) / 2
        
        return MKMapRect(x: x, y: y, width: width, height: height)
    }
}
