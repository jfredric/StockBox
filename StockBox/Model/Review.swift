//
//  Review.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import Firebase

class Review {
    var id: String
    var description: String
    var publisherID: String // userid of person who posts it
    var publisherName: String // name of user
    
    init(id: String, description: String, publisherID: String, publisherName: String) {
        self.id = id
        self.description = description
        self.publisherID = publisherID
        self.publisherName = publisherName
    }
}
