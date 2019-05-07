//
//  Item.swift
//  Todoey
//
//  Created by ccztr on 3/27/19.
//  Copyright © 2019 Chacer. All rights reserved.
//  Updated 5/07/2019  
//

import Foundation
import RealmSwift

// Realm Object
class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") // inverse relationship pointing to Category.items
}












