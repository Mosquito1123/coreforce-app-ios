//
//  BatteryReplacementStatus.swift
//  hfpower
//
//  Created by EDY on 2024/7/15.
//

import Foundation
import KakaJSON
struct BatteryReplacementStatus:Convertible{
    var id:Int?
    var title:String?
    var content:String?
    var type:Int = 0
}
