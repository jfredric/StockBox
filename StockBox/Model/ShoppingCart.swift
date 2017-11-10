//
//  ShoppingCart.swift
//  StockBox
//
//  Created by Jared Sobol on 11/8/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import FirebaseAuth

class ShoppingCart {

    // data
    var shoppingCartArray = [(Product, Int)]()

    // singleton
    static let sharedInstance = ShoppingCart()

    // NSCoder
    var filePath: String?
    private var hasLoaded = false

    func saveData() {
        if !hasLoaded {
            print("saving before data was loaded")
        }
        if let path = filePath {
            NSKeyedArchiver.archiveRootObject(shoppingCartArray, toFile: path)
        }
    }

    // initializer - loads NSCoder data
    private init() {

        let manager = FileManager.default

        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            errorAlert(message: "Could not locate user defaults document directory. Cart may not be saved if app is closed.", from: nil)
            return
        }

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user { // if not nil
                self.filePath = url.appendingPathComponent(user.uid + "/cart").path
            } else {
                self.filePath = url.appendingPathComponent("Guest/cart").path
            }
            if let path = self.filePath {
                if let cartData = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [(Product, Int)] {
                    // load the data
                    self.shoppingCartArray = cartData
                    self.hasLoaded = true
                } else {
                    print("Log [ShoppingCart] No data to load")
                }
            } else {
                errorAlert(message: "Error loading path", from: nil)
            }

        }
    }


}
