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
    
    // MARK: PRIVATE PROPERTIES
    
    private var _recipient: String = ""
    private var _street: String = ""
    private var _unit: String?
    private var _city: String = ""
    private var _state: String = ""
    private var _zipcode: String = ""
    private var _country: String = ""
    
    private var currentUser = AppUser.sharedInstance.currentUser
    
    // MARK: PROPERTIES, GETTERS & SETTERS
    
    var addressRef: DatabaseReference?
    
    var recipient: String {
        get { return _recipient}
        set {
            if currentUser != nil {
                _recipient = newValue
                addressRef?.child(FirebaseKeys.recipient).setValue(newValue)
            }
        }
    }
    var street: String {
        get { return _street}
        set {
            if currentUser != nil {
                _street = newValue
                addressRef?.child(FirebaseKeys.recipient).setValue(newValue)
            }
        }
    }
    var unit: String? {
        get { return _unit}
        set {
            if currentUser != nil {
                _unit = newValue
                addressRef?.child(FirebaseKeys.unit).setValue(newValue ?? "")
            }
        }
    }
    var city: String {
        get { return _city}
        set {
            if currentUser != nil {
                _city = newValue
                addressRef?.child(FirebaseKeys.city).setValue(newValue)
            }
        }
    }
    var state: String {
        get { return _state}
        set {
            if currentUser != nil {
                _state = newValue
                addressRef?.child(FirebaseKeys.state).setValue(newValue)
            }
        }
    }
    var zipcode: String {
        get { return _zipcode}
        set {
            if currentUser != nil {
                _zipcode = newValue
                addressRef?.child(FirebaseKeys.zipcode).setValue(newValue)
            }
        }
    }
    var country: String {
        get { return _country}
        set {
            if currentUser != nil {
                _country = newValue
                addressRef?.child(FirebaseKeys.country).setValue(newValue)
            }
        }
    }
    
    
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
    init(recipient:String, street:String, unit:String?, city:String, state:String, zipcode:String, country:String) {
        
        // initialize properties
        _recipient = recipient
        _street = street
        _unit = unit
        _city = city
        _state = state
        _zipcode = zipcode
        _country = country
        
        // get reference from firebase
        addressRef = AppDatabase.addressesRootRef.childByAutoId()
        
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
        _recipient = newAddressData[FirebaseKeys.recipient] as! String
        _street = newAddressData[FirebaseKeys.street] as! String
        _unit = newAddressData[FirebaseKeys.unit] as? String
        _city = newAddressData[FirebaseKeys.city] as! String
        _state = newAddressData[FirebaseKeys.state] as! String
        _zipcode = newAddressData[FirebaseKeys.zipcode] as! String
        _country = newAddressData[FirebaseKeys.country] as! String
    }
    
    // MARK: PUBLIC FUNCTIONS
    
    func toText() -> String {
        var newString = ""
        
        newString.append(_recipient)
        newString.append("\n" + _street)
        if _unit != nil {
            newString.append("\n" + _unit!)
        }
        newString.append("\n" + _city + ", " + _state + " " + String(_zipcode))
        newString.append("\n" + _country)
        
        return newString
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    // return data values as dictionary so it can be saved to firebase
    private func toAnyObject() -> [String:Any] {
        var currentData: [String:Any] = [
            FirebaseKeys.recipient : _recipient,
            FirebaseKeys.street : _street,
            FirebaseKeys.city : _city,
            FirebaseKeys.state : _state,
            FirebaseKeys.zipcode : _zipcode,
            FirebaseKeys.country : _country
        ]
        if _unit != nil {
            currentData[FirebaseKeys.unit] = _unit!
        }
        return currentData
    }
}
