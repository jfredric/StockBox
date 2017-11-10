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
    var cartIDs: [String] = []

    // singleton
    static let sharedInstance = ShoppingCart()

    // NSCoder
    var productsFilePath: String?
    var quantitiesFilePath: String?
    private var hasLoaded = false

    func saveData() {
        if !hasLoaded {
            print("Log [ShoppingCart]: Attempting to save before data was loaded")
        }
        if let productsFilePath = productsFilePath, let quantityFilePath = quantitiesFilePath {
            var products: [Product] = []
            var quantities: [Int] = []
            for (product, quantity) in shoppingCartArray {
                products.append(product)
                quantities.append(quantity)
            }
            let pSuccess = NSKeyedArchiver.archiveRootObject(products, toFile: productsFilePath)
            let qSuccess = NSKeyedArchiver.archiveRootObject(quantities, toFile: quantityFilePath)
            if pSuccess && qSuccess {
                print("Log [ShoppingCart]: Saved shopping cart data.")
            } else {
                print("Error [ShoppingCart]: Failed to save shopping cart data.")
            }
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
            self.hasLoaded = false
        
            if let user = user { // if not nil
                self.productsFilePath = url.appendingPathComponent(user.uid + "-cart-products").path
                self.quantitiesFilePath = url.appendingPathComponent(user.uid + "-cart-quantities").path
            } else {
                self.productsFilePath = url.appendingPathComponent("Guest-cart-products").path
                self.quantitiesFilePath = url.appendingPathComponent("Guest-cart-quantities").path
            }
            //self.filePath = url.appendingPathComponent("cart").path
            if let productsFilePath = self.productsFilePath, let quantityFilePath = self.quantitiesFilePath {
                if let productsData = NSKeyedUnarchiver.unarchiveObject(withFile: productsFilePath) as? [Product], let quantitiesData = NSKeyedUnarchiver.unarchiveObject(withFile: quantityFilePath) as? [Int] {
                    // load the data
                    var cartData: [(Product, Int)] = []
                    for (index, product) in productsData.enumerated() {
                        cartData.append( (product, quantitiesData[index]) )
                    }
                    self.shoppingCartArray = cartData
                } else {
                    print("Log [ShoppingCart] No data to load")
                }                
                self.hasLoaded = true
            } else {
                errorAlert(message: "Error loading path", from: nil)
            }

        }
    }


}
