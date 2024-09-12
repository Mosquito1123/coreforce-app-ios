//
//  BuyPackageCard.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import Foundation
import KakaJSON
struct BuyPackageCard:Convertible{
    var title: String?
    var subtitle: String?
    var cellHeight: CGFloat?
    var identifier: String?
    var icon: String?
    var enabled:Bool = true
    var items:[HFPackageCardModel]?
    var depositServices:[DepositService]?
}
