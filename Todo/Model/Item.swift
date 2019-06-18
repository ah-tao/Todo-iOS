//
//  Item.swift
//  Todo
//
//  Created by Taotao Ma on 6/17/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var createdAt: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
