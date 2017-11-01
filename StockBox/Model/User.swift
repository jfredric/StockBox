//
//  User.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation

class User {
    
    // MARK: PROPERTIES
    private var _uid: String?
    private var _account: AccountType = .consumer
    private var _name: String = "Guest"
    private var _balance: Double = 0.0
    private var _description: String = "" // vendor only
    private var _addresses: [Address] = [Address.guestAddress]
    
    static let guestUser = User()
    
    
    // MARK: CONSTANTS AND TYPES
    enum AccountType: String {
        case consumer = "consumer"
        case vendor = "vendor"
    }
    
    // MARK: INITIALIZERS
    private init() {}
    
    
}
