//
//  UsersProductDetailVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class UsersProductDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var colectionView: UICollectionView!
    
    @IBOutlet weak var venderBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productDescriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colectionView.delegate = self
        colectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        venderBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        reviewsBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        addToCartBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        reviewsBtn.layer.borderWidth = 1.0
        reviewsBtn.layer.borderColor = SECONDARYCOLOR.cgColor
        venderBtn.layer.borderWidth = 1.0
        venderBtn.layer.borderColor = SECONDARYCOLOR.cgColor
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProductDetailCVCell", for: indexPath) as? UserProductDetailCVCell else {
            fatalError("The World Is Ending")
        }
        
        return cell
    }
    
}
