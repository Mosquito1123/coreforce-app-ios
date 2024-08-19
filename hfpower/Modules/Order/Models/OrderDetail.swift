//
//  OrderDetail.swift
//  hfpower
//
//  Created by EDY on 2024/8/19.
//

import Foundation
import KakaJSON
struct OrderDetail:Convertible{
    var id:Int?
    var title:String?
    var status:Int?
    var type:Int?
    var items:[OrderDetailItem] = [OrderDetailItem]()
}
struct OrderDetailItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var extra:String?
 
}
