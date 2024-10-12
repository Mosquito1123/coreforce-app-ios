//
//  CityHistory.swift
//  hfpower
//
//  Created by EDY on 2024/10/12.
//

import Foundation
import KakaJSON
struct CityHistory:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var extra:String?
    var items:[CityHistoryItem]?
}
struct CityHistoryItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var extra:String?
    var isCurrent:Bool?
}
