//
//  Category.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class Category {
    var id: String
    var name: String
    var products: [String] = [] //productID's

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

