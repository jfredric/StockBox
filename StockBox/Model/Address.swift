//
//  Address.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class Address {
    
    // MARK: PROPERTIES
    var id:String?
    var recipient:String = "Guest"
    var street:String = ""
    var unit:String?
    var city:String = ""
    var state:String = ""
    var zipcode:String = ""
    var country:String = ""
    var ref: DatabaseReference?
    
    // MARK: CONSTANTS
    static let guestAddress = Address()
    
    //
    struct AddressKeys {
        static let id = "id"
        static let recipient = "recipient"
        static let street = "street"
        static let unit = "unit"
        static let city = "city"
        static let state = "state"
        static let zipcode = "zipcode"
        static let country = "country"
    }
    
    // MARK: INITIALIZERS
    private init() {
    }
    
    init(id:String, recipient:String, street:String, unit:String?, city:String, state:String, zipcode:String, country:String) {
        self.id = id
        self.recipient = recipient
        self.street = street
        self.unit = unit
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.country = country
        // get reference from firebase
        ref = AppDatabase.addressesRootRef.child(id)
    }
//    init(snapshot: DataSnapshot) {
//        
//    }
    
    // return data values as dictionary so it can be saved to firebase
    func toAnyObject() -> [String:Any] {
        return [
            AddressKeys.recipient : recipient,
            AddressKeys.street : street,
            AddressKeys.unit : unit ?? "",
            AddressKeys.city : city,
            AddressKeys.state : state,
            AddressKeys.zipcode : zipcode,
            AddressKeys.country : country
        ]

    }
}
