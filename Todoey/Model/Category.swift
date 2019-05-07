//
//  Category.swift
//  Todoey
//
//  Created by ccztr on 3/27/19.
//  Copyright © 2019 Chacer. All rights reserved.
//  Updated 5/07/2019  
//

import Foundation
import RealmSwift

// Realm Object
class Category : Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()        // Empty List of Item objects (foward relationship)
}













