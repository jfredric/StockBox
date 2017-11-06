//
//  AppUser.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class AppUser {
    
    // MARK: PRIVATE PROPERTIES
    private var currentUser: User?
    private var userInfoRef: DatabaseReference?
    private var _account: AccountType = .consumer
    private var _name: String = "Guest"
    private var _balance: Double = 0.0
    private var _description: String = "" // vendor only
    private var _addresses: [String] = [] // only one for vendor
    private var _favorites: [String] = [] // consumer only
    private var _products: [String] = [] // vendor only
    private var _reviews: [String] = [] // consumer only
    
    // MARK: GETTERS AND SETTERS
    var account: AccountType {
        get {
            return _account
        }
    }
    var name: String {
        get {
            return _name
        }
    }
    var balance: Double {
        get {
            return _balance
        }
    }
    
    // MARK: CONSTANTS AND TYPES
    enum AccountType: String{
        case consumer = "consumer"
        case vendor = "vendor"
    }
    
    struct FirebaseKeys {
        static let account = "account"
        static let name = "name"
        static let balance = "balance"
        static let description = "description"
        static let addresses = "addresses"
        static let favorites = "favorites"
        static let products = "products"
        static let reviews = "reviews"
    }
    
    // Singleton
    static let sharedInstance = AppUser()
    
    // MARK: INITIALIZERS
    private init() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // set the current user to the new user
                self.currentUser = user
                
                // set the database reference for UserInfo data
                self.userInfoRef = AppDatabase.userInfoRootRef.child(self.currentUser!.uid)
                
                // load data
                self.userInfoRef?.observeSingleEvent(of: .value, with: { (snapshot) in
                    let newUserInfo = snapshot.value as! [String:Any]
                    if let accountType = newUserInfo[FirebaseKeys.account] as? AccountType {
                        self._account = accountType
                    }
                    self._name = newUserInfo[FirebaseKeys.name] as? String ?? ""
                    self._balance = newUserInfo[FirebaseKeys.balance] as? Double ?? 0.0
                    self._description = newUserInfo[FirebaseKeys.description] as? String ?? ""
                    self._addresses = newUserInfo[FirebaseKeys.addresses] as? [String] ?? []
                    self._favorites = newUserInfo[FirebaseKeys.favorites] as? [String] ?? []
                    self._products = newUserInfo[FirebaseKeys.products] as? [String] ?? []
                    self._reviews = newUserInfo[FirebaseKeys.reviews] as? [String] ?? []
                })
                
            } else {
                // logged out, change to guest mode?
            }
        }
    }
    
    // MARK: CLASS METHODS
    
    func signUp(username: String, password: String, accountType: AccountType, completion: @escaping (_ error: Error?)->Void) {
        Auth.auth().createUser(withEmail: username, password: password) { (user, error) in
            if user != nil {// sign-up successful
                print("Log [AppUser]: new user created.")
                
                // tell the calling view that the user was created.
                completion(nil)
                
                // set the current user to the new user
                self.currentUser = user
                self._account = accountType
                
                // set the rest of the properties to default values as needed
                self._name = ""
                
                // creates the database reference for UserInfo data
                self.userInfoRef = AppDatabase.userInfoRootRef.child(self.currentUser!.uid)
                
                // write the users current info to firebase
                self.userInfoRef?.setValue(self.toAnyObject())
                
                // log the new user in
                Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
                    if error != nil { // This should not happen.
                        errorAlert(message: "Newly created user could not be logged in automatically.", from: nil)
                    } else {
                        print("Log [AppUser]: new user auto logged in.")
                        // Should not pass error back to caller because it will be seen as a failure to complete sign up.
                    }
                }
            } else {
                completion(error)
            }
        }
    }
    
    // Converts properties to a dicionary that can be written to Firebase
    func toAnyObject() -> Any {
        return [
            "account" : _account.rawValue,
            "name" : _name,
            "balance" : _balance,
            "description" : _description,
            "addresses" : _addresses,
            "favorites" : _favorites,
            "products" : _products,
            "reviews" : _reviews
        ]
    }
    
    // MARK PRIVATE FUNCTIONS
    private func loadGuestSettings() {
        // TBD
    }
    
    
    
    
}
