//
//  Product.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class Product/*: NSObject, NSCoding*/ {
    
    // MARK: PROPERTIES
    
    var id: String!
    var name: String
    var price: Double
    var description_: String
    var vendorID: String
    var category: Int // 0..2 : Spices Herds, Rubs
//    var categoriesIDs: [String] = []
    var reviews: [Review] = [] // not nscoded or firebase
    var reviewsIDs: [String] = []
    var images: [String] = [] // not nscoded or firebase
    var imagesURLs: [String] = []
    var productRef: DatabaseReference!
    
    // MARK: CONSTANTS
    
    struct FirebaseKeys {
        static let name = "name"
        static let price = "price"
        static let description = "description"
        static let vendorID = "vendorID"
        static let category = "catergory"
        static let reviews = "reviews"
        static let images = "images"
        
    }
    
    struct CodingKeys {
        static let id = "id"
        static let name = "name"
        static let price = "price"
        static let description = "description"
        static let vendorID = "vendorID"
        static let category = "catergory"
        static let reviews = "reviews"
        static let images = "images"
    }
    
    // MARK: NSCODING
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: CodingKeys.id)
//        aCoder.encode(name, forKey: CodingKeys.name)
//        aCoder.encode(price, forKey: CodingKeys.price)
//        aCoder.encode(description_, forKey: CodingKeys.description)
//        aCoder.encode(vendorID, forKey: CodingKeys.vendorID)
//        aCoder.encode(id, forKey: CodingKeys.id)
//        aCoder.encode(id, forKey: CodingKeys.id)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        if let nameObject = aDecoder.decodeObject(forKey: CodingKeys.id) as? String {
//            id = nameObject
//            // load Product from ID
//            productRef = AppDatabase.productsRootRef.child(id)
//        } else {
//            // could not find id?
//        }
//    }
    
    // MARK: INITIALIZERS
    
    init (name: String, price: Double, description: String, vendorID: String, category: Int, imagesURLs: [String]) {
        
        productRef = AppDatabase.productsRootRef.childByAutoId() //refernace of the root of the prodcuts
        id = productRef.key
        self.name = name
        self.price = price
        self.description_ = description
        self.vendorID = vendorID
        self.category = category
        self.imagesURLs = imagesURLs
        //note: images may need to be downloaded here
        
        //write to firebase
        productRef.setValue(toAnyObject())
        
    }
    
    init(snapShot: DataSnapshot) {
        productRef = snapShot.ref
        
        guard let data = snapShot.value as? [String:Any] else {
            fatalErrorAlert(message: "database return invalid data", from: nil)
            fatalError()
        }
        
        name = data[FirebaseKeys.name] as! String
        price = data[FirebaseKeys.price] as! Double
        description_ = data[FirebaseKeys.description] as! String
        vendorID = data[FirebaseKeys.vendorID] as! String
        category = data[FirebaseKeys.category] as! Int
        reviewsIDs = data[FirebaseKeys.reviews] as? [String] ?? []
        imagesURLs = data[FirebaseKeys.images] as? [String] ?? []
    }
    
    // MARK: HELPER FUNCTIONS
    
    func contains(text: String) -> Bool {
        // Swift 4.0 == range(of: find, options: .caseInsensitive)
        let find = text.lowercased()
        
        if name.lowercased().range(of: find) != nil {
            return true
        }
        
        if name.lowercased().range(of: find) != nil {
            return true
        }
        
        // reviews here
        
        return false
    }
    
    func appendImage(url: String){
        imagesURLs.append(url)
        productRef.child(FirebaseKeys.images).setValue(imagesURLs)
    }
    
    func toAnyObject() -> [String:Any] {
        let asDictionary: [String:Any] = [
            FirebaseKeys.name: name,
            FirebaseKeys.price: price,
            FirebaseKeys.description: description_,
            FirebaseKeys.vendorID: vendorID,
            FirebaseKeys.category: category,
            FirebaseKeys.reviews: reviewsIDs,
            FirebaseKeys.images: imagesURLs
            ]
        return asDictionary
    }
}
