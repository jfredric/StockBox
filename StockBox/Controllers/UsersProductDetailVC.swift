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
            let venderLocation = value?["address"] as? String ?? "Empty"
            self.venderLocation.text = venderLocation
    
        }) { (error) in
            print(error.localizedDescription)
        }
        
        if currentProduct.description_ == "" {
            productDescriptionTextField.text = "There is no description for this product"
        } else {
            productDescriptionTextField.text = currentProduct.description_
        }
        for image in currentProduct.images {
            let productImageURL = URL(string: image)
            let data = try? Data(contentsOf: productImageURL!)
            let currentImage = UIImage(data: data!)
            productImages.append(currentImage!)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
//        venderBtn.layer.cornerRadius = BUTTONCORNERRADIUS
//        reviewsBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        addToCartBtn.layer.cornerRadius = BUTTONCORNERRADIUS
//        reviewsBtn.layer.borderWidth = 1.0
//        reviewsBtn.layer.borderColor = SECONDARYCOLOR.cgColor
//        venderBtn.layer.borderWidth = 1.0
//        venderBtn.layer.borderColor = SECONDARYCOLOR.cgColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func reviewsBtnPressed(_ sender: Any) {
    }
    
    @IBAction func addToCartBtnPressed(_ sender: Any) {
    }
    
    @IBAction func vendersBtnPresssed(_ sender: Any) {
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
