//
//  ShoppingCart.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

class ShoppingCart: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        print("fix this")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("fix this")
    }
    
    static let sharedInstance = ShoppingCart()
    static let shoppingCartArray = [(Product, Int)]()
    private override init() {
    }
}
