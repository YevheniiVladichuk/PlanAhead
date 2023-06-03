//
//  Data.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 27/05/2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var categoryName: String = ""
    
// define relationship
    let items = List<Item>()

}
