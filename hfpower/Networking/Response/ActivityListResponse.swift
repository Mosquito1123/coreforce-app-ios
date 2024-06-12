//
//  ActivityListResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/11.
//

import Foundation
import KakaJSON
struct ActivityListResponse<T:Convertible>:Convertible {
    var inviteList:[T]?
}
struct ActivityResponse:Convertible{
    var endTime:String?
    var name:String?
    var serialNo:String?
    var startTime:String?
    var url:String?
    var photo:String?
    var introduction:String?
    var type:Int?

}
