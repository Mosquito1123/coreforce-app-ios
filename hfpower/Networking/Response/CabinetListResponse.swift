//
//  CabinetListResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
import KakaJSON
struct CabinetListResponse:Convertible{
    var list:[CabinetSummary]?
}
struct CabinetSummary:Convertible {
    var id:Int?
    var number:String?
    var status:Int?
    var bdLat:NSString?
    var bdLon:NSString?
    var gdLat:NSString?
    var gdLon:NSString?
    var heartbeatAt:String?
    var location:String?
    var photo1:String?
    var photo2:String?
    var photo3:String?
    var rentReturnBattery:Bool?
    var cabinetType:Int?
    var gridCount:Int?
    var agentId:Int?
    var agentName:String?
    var agentPhoneNum:String?
    var batteryCount:Int?
    var onLine:Bool?

}
