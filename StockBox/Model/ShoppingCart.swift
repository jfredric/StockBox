//
//  ShoppingCart.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

class ShoppingCart {
    static let sharedInstance = ShoppingCart()
    static let shoppingCartArray = [Product]()
    private init() {
    }
}
