//
//  Product.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class Product {
    var id: String!
    var name: String
    var price: Double
    var description: String
    var vendorID: String
    var categories: [Category] = []
    var categoriesIDs: [String] = []
    var reviews: [Review] = []
    var reviewsIDs: [String] = []
    var images: [String] = []
    var imagesURLs: [String] = []
    var productRef: DatabaseReference!
    
    init (name: String, price: Double, description: String, vendorID: String, imagesURLs: [String]) {
        
        productRef = AppDatabase.productsRootRef.childByAutoId() //refernace of the root of the prodcuts
        id = productRef.key
        self.name = name
        self.price = price
        self.description = description
        self.vendorID = vendorID
        reviews = []
        self.imagesURLs = imagesURLs
        //note: images may need to be downloaded here
        
        //write to firebase
        productRef.setValue(toAnyObject())
        
        
    }
    
    struct FirebaseKeys {
        static let name = "name"
        static let price = "price"
        static let description = "description"
        static let vendorID = "vendorID"
        static let categories = "catergories"
        static let reviews = "reviews"
        static let images = "images"
    
    }
    func toAnyObject() -> [String:Any] {
        let asDictionary: [String:Any] = [
            FirebaseKeys.name: name,
            FirebaseKeys.price: price,
            FirebaseKeys.description: description,
            FirebaseKeys.vendorID: vendorID,
            FirebaseKeys.categories: categoriesIDs,
            FirebaseKeys.reviews: reviewsIDs,
            FirebaseKeys.images: imagesURLs
            ]
        return asDictionary
    }
    
    func appendImage(url: String){
        imagesURLs.append(url)
        productRef.child(FirebaseKeys.images).setValue(imagesURLs)
    }
}
