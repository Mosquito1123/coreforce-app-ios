//
//  CabinetFilter.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import Foundation
import KakaJSON
struct CabinetFilter:Convertible{
    var id:Int?
    var title:String?
    var filterItems:[CabinetFilterItem]?
    
}
struct CabinetFilterItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var selected:Bool?
}
