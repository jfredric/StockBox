//
//  ShoppingCartVC.swift
//  StockBox
//
//  Created by Jared Sobol on 11/1/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class ShoppingCartVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ShoppingCart.sharedInstance.shoppingCartArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as? ShoppingCartCollectionViewCell else {
            fatalError("The World Is Ending")
        }
        cell.productTitle.text = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.name
        let vendorID = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.vendorID
        AppDatabase.userInfoRootRef.child(vendorID).observeSingleEvent(of: .value, with: { (userSnapshot) in
            let userValue = userSnapshot.value as? NSDictionary
            let vendorName = userValue?[AppUser.FirebaseKeys.name] as? String ?? ""
            let vendorAddress = userValue?[AppUser.FirebaseKeys.addresses] as? [String] ?? []
            cell.verderName.text = vendorName
            AppDatabase.addressesRootRef.child(vendorAddress[0]).observeSingleEvent(of: .value, with: { (addressSnapshot) in
                let addressValue = addressSnapshot.value as? NSDictionary
                let vendorCity = addressValue?[Address.FirebaseKeys.city] as? String ?? ""
                let vendorCountry = addressValue?[Address.FirebaseKeys.country] as? String ?? ""
                cell.venderLocation.text = "\(vendorCity), \(vendorCountry)"
            })
        })
        
        cell.numOfProducts.text = "$\(ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].1)"
        let countOfProducts = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].1
        let currentPrice = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.price
        cell.productPrice.text = "$\(currentPrice)"
        let currentTotal = currentPrice * Double(countOfProducts)
        cell.totalLbl.text = "$\(currentTotal)"
        return cell
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        print("I am here")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func checkOutBtnPressed(_ sender: Any) {
        
    }
    
}
