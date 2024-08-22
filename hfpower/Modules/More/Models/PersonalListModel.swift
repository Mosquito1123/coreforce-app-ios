//
//  PersonalList.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import Foundation
import KakaJSON
struct PersonalList:Convertible{
    var id:Int?
    var title: String?
    var subtitle: String?
    var cellHeight: CGFloat?
    var identifier: String?
    var detail: String?
    var items:[PersonalListItem]?
    var extra:Any?
}
struct PersonalListItem:Convertible{
    var id:Int?
    var title: String?
    var subtitle: String?
    var icon:String?
}
