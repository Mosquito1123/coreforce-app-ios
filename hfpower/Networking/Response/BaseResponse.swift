//
//  BaseResponse.swift
//  hfpower
//
//  Created by EDY on 2024/6/5.
//

import Foundation
import KakaJSON
struct Header:Convertible{
    var createTime:String?
    var requestNo:String?
    var retFlag:String?
    var retMsg:String?
}
struct CommonResponse<T:Convertible>:Convertible{
    var body:T?
    var head:Header?
}
