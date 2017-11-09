//
//  favorites.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

class Favorites: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Favorites.favoritesArray, forKey: "Favorites")
    }
    
    required init?(coder aDecoder: NSCoder) {
//        if let FavoritesArray = aDecoder.decodeObject(forKey: Keys.name) as? String {
//            
//        }
    }
    
    static let sharedInstance = Favorites()
    static let favoritesArray = [Product]()
    private override init() {
    }
    
}
