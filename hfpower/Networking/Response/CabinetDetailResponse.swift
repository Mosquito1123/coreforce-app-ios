//
//  CabinetDetailResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/21.
//

import Foundation
import KakaJSON
struct CabinetDetailResponse:Convertible{
    var cabinet:CabinetSummary?
    var gridList:[GridSummary]?
    var cabinetExchangeForecast:[CabinetExchangeForecast]?
}
struct CabinetExchangeForecast:Convertible{
    var count:NSNumber?
    var hh:NSNumber?
}
struct GridSummary:Convertible{
    var batteryNumber: String?
    var batteryTypeName: String?
    var createAt: String?
    var extinguisher: String?
    var memo: String?
    var updateAt: String?
    var batteryCapacityPercent: NSNumber?
    var batteryId: NSNumber?
    var batteryStatus: NSNumber?
    var cabinetId: NSNumber?
    var cabinetOnLine: NSNumber?
    var charger: NSNumber?
    var errStatus: NSNumber?
    var gridNum: NSNumber?
    var id: NSNumber?
    var light: NSNumber?
    var lock: NSNumber?
    var mac: NSNumber?
    var specs: NSNumber?
    var status: NSNumber?
    var statusUpdateBy: NSNumber?
    var temperature: NSNumber?
}
