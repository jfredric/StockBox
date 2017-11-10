//
//  favorites.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import FirebaseAuth

class Favorites {
    
    // MARK: PROPERTIES
    
    var products = [Product]()
    
    // MARK: SINGLETON
    
    static let sharedInstance = Favorites()

    // NSCoder
    var filePath: String?
    private var hasLoaded = false
    
    func saveData() {
        if !hasLoaded {
            print("Log [Favorites]: Attempting to save before data was loaded")
        }
        if let path = filePath {
            let success = NSKeyedArchiver.archiveRootObject(products, toFile: path)
            if success {
                print("Log [Favorites]: Saved favorites data.")
            } else {
                print("Error [Favorites]: Failed to save favorites data.")
            }
        }
    }
    
    // initializer - loads NSCoder data
    private init() {
        
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            errorAlert(message: "Could not locate user defaults document directory. Favorites may not be saved if app is closed.", from: nil)
            return
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.hasLoaded = false
            if let user = user { // if not nil
                self.filePath = url.appendingPathComponent(user.uid + "-favorites").path
            } else {
                self.filePath = url.appendingPathComponent("Guest-favorites").path
            }
            if let path = self.filePath {
                if let favoritesData = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Product] {
                    // load the data
                    self.products = favoritesData
                    self.hasLoaded = true
                } else {
                    print("Log [Favorites] No data to load")
                }
            } else {
                errorAlert(message: "Error loading path", from: nil)
            }
            
        }
    }
    
}
