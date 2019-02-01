//
//  Category.swift
//  Todoey
//
//  Created by Apok Developer on 1/31/19.
//  Copyright © 2019 Apok Developer. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
