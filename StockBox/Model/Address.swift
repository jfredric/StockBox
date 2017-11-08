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
    var recipient:String = ""
    var street:String = ""
    var unit:String?
    var city:String = ""
    var state:String = ""
    var zipcode:String = ""
    var country:String = ""
    var addressRef: DatabaseReference?
    
    // MARK: CONSTANTS
    
    struct FirebaseKeys {
        static let recipient = "recipient"
        static let street = "street"
        static let unit = "unit"
        static let city = "city"
        static let state = "state"
        static let zipcode = "zipcode"
        static let country = "country"
    }
    
    // MARK: INITIALIZERS
    
    // create new empty address, possibly used for Guest.
    init() {
    }
    
    // create new object from user inputed values
    init(id:String, recipient:String, street:String, unit:String?, city:String, state:String, zipcode:String, country:String) {
        
        // initialize properties
        self.recipient = recipient
        self.street = street
        self.unit = unit
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.country = country
        
        // get reference from firebase
        addressRef = AppDatabase.addressesRootRef.child(id)
        
        // write new object to database
        addressRef?.setValue(toAnyObject())
    }
    
    // create object from pre-existing firebase data entry
    init(snapshot: DataSnapshot) {
        // save the database reference
        addressRef = snapshot.ref
        
        // unwrap data from snapshot into usable Dictionary
        guard let newAddressData = snapshot.value as? [String:Any] else {
            fatalErrorAlert(message: "database return invalid data", from: nil)
            return
        }
        
        // initialize properties with received data
        recipient = newAddressData[FirebaseKeys.recipient] as! String
        street = newAddressData[FirebaseKeys.street] as! String
        unit = newAddressData[FirebaseKeys.unit] as? String
        city = newAddressData[FirebaseKeys.city] as! String
        state = newAddressData[FirebaseKeys.state] as! String
        zipcode = newAddressData[FirebaseKeys.zipcode] as! String
        country = newAddressData[FirebaseKeys.country] as! String
    }
    
    // MARK: PUBLIC FUNCTIONS
    
    func toText() -> String {
        var newString = ""
        
        newString.append(recipient)
        newString.append("\n" + street)
        if unit != nil {
            newString.append("\n" + unit!)
        }
        newString.append("\n" + city + ", " + state + " " + String(zipcode))
        newString.append("\n" + country)
        
        return newString
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    // return data values as dictionary so it can be saved to firebase
    private func toAnyObject() -> [String:Any] {
        return [
            FirebaseKeys.recipient : recipient,
            FirebaseKeys.street : street,
            FirebaseKeys.unit : unit ?? "",
            FirebaseKeys.city : city,
            FirebaseKeys.state : state,
            FirebaseKeys.zipcode : zipcode,
            FirebaseKeys.country : country
        ]

    }
}
