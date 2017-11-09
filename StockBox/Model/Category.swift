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
    var name: String
    var products: [String] = [] //productID's
    var categoriesRef: DatabaseReference!

    init(name: String, products: [String]) {
        categoriesRef = AppDatabase.categoriesRootRef.childByAutoId()
        self.name = name
        self.products = products
        
        categoriesRef.setValue(toAnyObject())
    }

    struct FirebaseKeys {
        static let name = "name"
        static let products = "products"
    }

    func toAnyObject() -> [String:Any] {
        let toDictionary: [String:Any] = [
            FirebaseKeys.name : name,
            FirebaseKeys.products : products
            ]
        return toDictionary
    }
}

