//
//  DepositManagement.swift
//  hfpower
//
//  Created by EDY on 2024/8/14.
//

import Foundation
import KakaJSON
struct DepositManagement:Convertible{
    var id:Int = 0
    var title:String = ""
    var items:[DepositManagementItem] = [DepositManagementItem]()
}
struct DepositManagementItem:Convertible{
    var id:Int = 0
    var title:String = ""
    var content:String = ""
    var selected:Bool = false
    var type:Int = 0
}
