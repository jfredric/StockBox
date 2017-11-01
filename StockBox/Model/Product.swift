//
//  Product.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

class Product {
    var id: String
    var name: String
    var price: Double
    var description: String
    var vendorID: String
    var categories: [Category] = []
    var reviews: [Review] = []
    var images: [String] = []
    
    init(id: String, name: String, price: Double, description: String, vendorID: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.vendorID = vendorID
    }
}
