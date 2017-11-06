//
//  UsersProductDetailVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class UsersProductDetailVC: UIViewController {
    
    @IBOutlet weak var venderBtn: UIButton!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productDescriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        venderBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        reviewsBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        addToCartBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        reviewsBtn.layer.borderWidth = 1.0
        reviewsBtn.layer.borderColor = MAINORANGECOLOR.cgColor
        venderBtn.layer.borderWidth = 1.0
        venderBtn.layer.borderColor = MAINORANGECOLOR.cgColor
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
    
    
}
