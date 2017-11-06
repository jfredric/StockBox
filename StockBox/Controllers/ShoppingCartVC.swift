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
        collectionView.register(UINib.init(nibName: "ShoppingCartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shoppingCartCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingCartCell", for: indexPath) as? ShoppingCartCollectionViewCell else {
            fatalError("The World Is Ending")
        }
        cell.productTitle.text = "Tumeric"
        cell.verderName.text = "The Spice World"
        cell.venderLocation.text = "Chennai, India"
        cell.numOfProducts.text = "2"
        cell.productPrice.text = "10.28"
        return cell
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        print("I am here")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func checkOutBtnPressed(_ sender: Any) {
        
    }
    
}
