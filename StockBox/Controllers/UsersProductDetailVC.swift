//
//  UsersProductDetailVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase

class UsersProductDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var colectionView: UICollectionView!
    

    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var venderLocation: UILabel!
    @IBOutlet weak var venderTitle: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productDescriptionTextField: UITextView!
    
    var currentProduct: Product!
    var productImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colectionView.delegate = self
        colectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        productTitleLbl.text = currentProduct.name
        productPriceLbl.text = "$\(currentProduct.price)"
        AppDatabase.userInfoRootRef.child(currentProduct.vendorID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let vendorTitle = value?["name"] as? String ?? "Empty"
            self.venderTitle.text = vendorTitle
            let addressIDs = value?[AppUser.FirebaseKeys.addresses] as? [String] ?? []
            if addressIDs.count == 0 {
                self.venderLocation.text = "Unknown"
            } else {
                AppDatabase.addressesRootRef.child(addressIDs[0]).observeSingleEvent(of: .value, with: { (addressSnapshot) in
                    let addressValue = addressSnapshot.value as? NSDictionary
                    let vendorCity = addressValue?[Address.FirebaseKeys.city] as? String ?? ""
                    let vendorCountry = addressValue?[Address.FirebaseKeys.country] as? String ?? ""
                    self.venderLocation.text = "\(vendorCity), \(vendorCountry)"
                })
            }
            // self.venderLocation.text = venderLocation
        }) { (error) in
            print(error.localizedDescription)
        }
        
        if currentProduct.description_ == "" {
            productDescriptionTextField.text = "There is no description for this product"
        } else {
            productDescriptionTextField.text = currentProduct.description_
        }
        
        for imageUrl in currentProduct.imagesURLs {
            let productImageURL = URL(string: imageUrl)
            let data = try? Data(contentsOf: productImageURL!)
            let currentImage = UIImage(data: data!)
            productImages.append(currentImage!)
        }
        colectionView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
//        venderBtn.layer.cornerRadius = BUTTONCORNERRADIUS
//        reviewsBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        addToCartBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        favoritesBtn.layer.cornerRadius = BUTTONCORNERRADIUS
//        reviewsBtn.layer.borderWidth = 1.0
//        reviewsBtn.layer.borderColor = SECONDARYCOLOR.cgColor
//        venderBtn.layer.borderWidth = 1.0
//        venderBtn.layer.borderColor = SECONDARYCOLOR.cgColor
    }
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func favoritesBtnClicked(_ sender: Any) {
        for arrayProduct in Favorites.sharedInstance.products {
            if currentProduct.id == arrayProduct.id {
                messageAlert(title: "Already in Favorites", message: "You already have \(currentProduct.name) in your favorites list.", from: self)
                return
            }
        }
        
        messageAlert(title: "Added to Favorites", message: "We have added \(currentProduct.name) to your favorites list.", from: self)
        Favorites.sharedInstance.products.append(currentProduct)
        print("Log [U_ProductDetail]: Adding \(currentProduct.name) to favorites. [\(currentProduct.id)]")
    }

    @IBAction func addToCartBtnPressed(_ sender: Any) {
        for (index,arrayProduct) in ShoppingCart.sharedInstance.shoppingCartArray.enumerated() {
            //if currentProduct.name == arrayProduct.0.name && currentProduct.price == arrayProduct.0.price{ // why???
            if currentProduct.id == arrayProduct.0.id {
                ShoppingCart.sharedInstance.shoppingCartArray[index].1 += 1
                print("Log [U_ProductDetail]: \(currentProduct.name) already in cart, increasing quantity to \(ShoppingCart.sharedInstance.shoppingCartArray[index].1). [\(currentProduct.id)]")
                messageAlert(title: "Added to Cart", message: "We have added another \(currentProduct.name) to your cart.", from: self)
                return
            }
        }
        print("Log [U_ProductDetail]: Adding \(currentProduct.name) to cart. [\(currentProduct.id)]")
        ShoppingCart.sharedInstance.shoppingCartArray.append((currentProduct,1))
        messageAlert(title: "Added to Cart", message: "We have added \(currentProduct.name) to your cart.", from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if productImages.count == 0 {
            return 1
        } else {
            return productImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProductDetailCVCell", for: indexPath) as? UserProductDetailCVCell else {
            fatalError("The World Is Ending")
        }
        if productImages.count == 0 {
            cell.productImage.image = #imageLiteral(resourceName: "quickadd")
        } else {
            cell.productImage.image = productImages[indexPath.row]
        }
        return cell
    }
    
}
