//
//  Int+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/4/12.
//

import Foundation
extension Int {
    static var requestNo:Int{
        return Int(arc4random())
    }
}
extension UInt32{
    static var requestNo:UInt32{
        return arc4random()
    }
}

