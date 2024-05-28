//
//  CenterPointAnnotation.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
import MapKit
// 自定义标记类
class CenterAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
}

// MARK: - Public
extension CenterAnnotation {
    
}

// MARK: - Private
private extension CenterAnnotation {
    
}
