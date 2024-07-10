//
//  PackageCard.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import Foundation
import KakaJSON
//套餐卡模型
struct PackageCard:Convertible{
    var sort: NSNumber?
    var price: NSNumber?
    var days: NSNumber?
    var id: NSNumber?
    var saleFromDate: String?
    var saleToDate: String?
    var tag: String?
    var originalPrice: NSNumber?
    var selected:Bool = false
    var type:Int = 0
}
