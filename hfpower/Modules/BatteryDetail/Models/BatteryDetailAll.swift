//
//  BatteryDetailAll.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import Foundation
import IGListKit
import KakaJSON
class BatteryStatus:ListDiffable{
    let id: Int
    let batteryDetail:BatteryDetail
    init(id: Int,batteryDetail:BatteryDetail) {
        self.id = id
        self.batteryDetail = batteryDetail
    }
    
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryStatus else { return false }
        return batteryDetail.id == object.batteryDetail.id
    }
    
    
}
struct BatteryInfoItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
}
class BatteryInfo:ListDiffable{
    let id: Int
    let items:[BatteryInfoItem]
    init(id: Int, items:[BatteryInfoItem]) {
        self.id = id
        self.items = items
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryInfo else { return false }
        return id == object.id
    }
}

class BatteryRemainingTerm:ListDiffable{
    let id: Int
    let title:String
    let content: String
    let overdueOrExpiringSoon:Bool
    init(id: Int,title:String,content:String,overdueOrExpiringSoon:Bool) {
        self.id = id
        self.title = title
        self.content = content
        self.overdueOrExpiringSoon = overdueOrExpiringSoon
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryRemainingTerm else { return false }
        return id == object.id
    }
}
class BatteryAgent:ListDiffable{
    let id: Int
    let title:String
    let agentName: String
    init(id: Int,title:String,agentName:String) {
        self.id = id
        self.title = title
        self.agentName = agentName
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryAgent else { return false }
        return id == object.id
    }
}
struct BatteryActionItem:Convertible{
    var id:Int?
    var name:String?
    var icon:String?
}
class BatteryAction:ListDiffable{
    let id: Int
    let items:[BatteryActionItem]
    init(id: Int, items:[BatteryActionItem]) {
        self.id = id
        self.items = items
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryAction else { return false }
        return id == object.id
    }
}
struct BatterySiteItem:Convertible{
    var id:Int?
    var name:String?
}
class BatterySite:ListDiffable{
    let id: Int
    let sites:[BatterySiteItem]
    init(id: Int, sites:[BatterySiteItem]) {
        self.id = id
        self.sites = sites
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatterySite else { return false }
        return id == object.id
    }
}

