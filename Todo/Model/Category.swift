//
//  Category.swift
//  Todo
//
//  Created by Taotao Ma on 6/17/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
