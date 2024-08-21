//
//  BatteryDetail.swift
//  hfpower
//
//  Created by EDY on 2024/8/21.
//

import Foundation
import IGListKit
import KakaJSON
class BatteryStatus:ListDiffable{
    let id: Int
    let value: String
    let status: Int
    let address:String
    init(id: Int, value: String,status:Int,address:String) {
        self.id = id
        self.value = value
        self.status = status
        self.address = address
    }
    
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryStatus else { return false }
        return value == object.value
    }
    
    
}
class BatteryInfo:ListDiffable{
    let id: Int
    let num: String
    let vin:String
    init(id: Int, num: String,vin:String) {
        self.id = id
        self.num = num
        self.vin = vin
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BatteryInfo else { return false }
        return vin == object.vin
    }
}

class BatteryRemainingTerm:ListDiffable{
    let id: Int
    let remainingTerm: String
    init(id: Int,remainingTerm:String) {
        self.id = id
        self.remainingTerm = remainingTerm
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
    let agentName: String
    init(id: Int,agentName:String) {
        self.id = id
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

