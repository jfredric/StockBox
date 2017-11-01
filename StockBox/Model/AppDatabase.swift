//
//  AppDatabase.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class AppDatabase {
    
    // Root references into firebase
    static let rootRef = Database.database().reference()
    static let userInfoRootRef = rootRef.child("UserInfo")
    static let addressesRootRef = rootRef.child("Addresses")
    static let productsRootRef = rootRef.child("Products")
    static let reviewsRootRef = rootRef.child("Reviews")
    static let categoriesRootRef = rootRef.child("Categories")
}
