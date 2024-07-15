//
//  TableState.swift
//  hfpower
//
//  Created by EDY on 2024/7/15.
//

import UIKit
import EmptyStateKit

enum TableState: CustomState {
    case noCoupon
    var image:UIImage?{
        switch self {
        case .noCoupon:
            return nil
        }
    }
    var title:String?{
        switch self {
        case .noCoupon:
            return "暂无可用优惠券"
        }
    }
    var format: EmptyStateFormat {
        switch self {
        case .noCoupon:
            var format = EmptyStateFormat()
            format.titleAttributes = [
                .font:UIFont.systemFont(ofSize: 14),
                .foregroundColor:UIColor(rgba: 0x86909CFF)
            ]
            return format
 
        }
    }
}
