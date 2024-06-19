//
//  CabinetAnnotation.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import UIKit
import MapKit
// 自定义标记类
class CabinetAnnotation: NSObject, MKAnnotation {
    var cabinet:CabinetSummary?
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    
}

