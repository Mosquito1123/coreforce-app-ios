//
//  FirstContent.swift
//  hfpower
//
//  Created by EDY on 2024/10/14.
//

import Foundation
import KakaJSON
struct FirstContent:Convertible{
    var id:Int?
    var identifier:String?
    var title:String?
    var content:String?
    var extra:String?
    var type:Int?
    var selected:Bool?
    var items:[FirstContentItem]?
    
}
struct FirstContentItem:Convertible{
    var id:Int?
    var identifier:String?
    var title:String?
    var content:String?
    var type:Int?
    var selected:Bool?
    var extra:String?
}
