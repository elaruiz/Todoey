//
//  Todo.swift
//  Todoey
//
//  Created by Apok Developer on 1/30/19.
//  Copyright © 2019 Apok Developer. All rights reserved.
//

import UIKit

class Item : Codable {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
