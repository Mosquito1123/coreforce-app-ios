//
//  BikeDetailAll.swift
//  hfpower
//
//  Created by EDY on 2024/8/20.
//

import Foundation
import IGListKit
import KakaJSON
class BikeStatus:ListDiffable{
    let id: Int
    let bikeDetail:BikeDetail
    init(id: Int, bikeDetail:BikeDetail) {
        self.id = id
        self.bikeDetail = bikeDetail
    }
    
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BikeStatus else { return false }
        return bikeDetail.id == object.bikeDetail.id
    }
    
    
}
struct BikeInfoItem:Convertible{
    var id:Int?
    var title:String?
    var content:String?
}
class BikeInfo:ListDiffable{
    let id: Int
    let items: [BikeInfoItem]
    init(id: Int, items:[BikeInfoItem]) {
        self.id = id
        self.items = items
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BikeInfo else { return false }
        return id == object.id
    }
}

class BikeRemainingTerm:ListDiffable{
    let id: Int
    let title:String
    let content: String
    let overdueOrExpiringSoon:Bool
    init(id: Int,title:String,content:String,overdueOrExpiringSoon:Bool = false) {
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
        guard let object = object as? BikeRemainingTerm else { return false }
        return id == object.id
    }
}
class BikeAgent:ListDiffable{
    let id: Int
    let title:String
    let content: String
    init(id: Int,title:String,content:String) {
        self.id = id
        self.title = title
        self.content = content
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BikeAgent else { return false }
        return id == object.id
    }
}
struct BikeActionItem:Convertible{
    var id:Int?
    var name:String?
    var icon:String?
}
class BikeAction:ListDiffable{
    let id: Int
    let items:[BikeActionItem]
    init(id: Int, items:[BikeActionItem]) {
        self.id = id
        self.items = items
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BikeAction else { return false }
        return id == object.id
    }
}
struct BikeSiteItem:Convertible{
    var id:Int?
    var name:String?
}
class BikeSite:ListDiffable{
    let id: Int
    let sites:[BikeSiteItem]
    init(id: Int, sites:[BikeSiteItem]) {
        self.id = id
        self.sites = sites
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? BikeSite else { return false }
        return id == object.id
    }
}
class ContactInfo:ListDiffable{
    let id: Int
    let name:String
    let phoneNumber:String
    init(id: Int, name:String,phoneNumber:String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
    // MARK: - ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ContactInfo else { return false }
        return id == object.id
    }
}
