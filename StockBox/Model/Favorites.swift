//
//  favorites.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

// does not need to be NSCoding. This is a singleton.
class Favorites { //: NSObject, NSCoding {
    
    // MARK: PROPERTIES
    
    var products = [Product]()
    
    // MARK: SINGLETON
    
    static let sharedInstance = Favorites()
    
    private init() {
    }
    
//    // MARK: NSCODING DELEGATE FUNCTIONS
//
//    struct CodingKeys {
//        static let favorites = "favorites"
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(products, forKey: CodingKeys.favorites)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//
//    }
    
}
