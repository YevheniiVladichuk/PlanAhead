//
//  Item.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 28/05/2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    
// define inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
