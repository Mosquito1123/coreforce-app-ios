//
//  PersonalListModel.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import Foundation
struct PersonalListModel{
    var title: String
    var subtitle: String?
    var cellHeight: CGFloat?
    var identifier: String?
    var icon: UIImage?
    var detail: String?
    var action: ((_ sender:UIButton) -> Void)?
}
