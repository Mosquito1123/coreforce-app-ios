//
//  Settings.swift
//  hfpower
//
//  Created by EDY on 2024/7/8.
//

import Foundation
import KakaJSON
struct Settings:Convertible{
    var id:Int = 0
    var title:String = ""
    var items:[SettingsItem] = [SettingsItem]()
}
struct SettingsItem:Convertible{
    var id:Int = 0
    var title:String = ""
    var content:String = ""
    var selected:Bool = false
    var type:Int = 0
}
