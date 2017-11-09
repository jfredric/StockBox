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
        <#code#>
    }
    
    required init?(coder aDecoder: NSCoder) {
        <#code#>
    }
    
    static let sharedInstance = ShoppingCart()
    static let shoppingCartArray = [Product]()
    private override init() {
    }
}
