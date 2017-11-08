//
//  VendorProfileVC.swift
//  StockBox
//
//  Created by Grishma Athavale on 10/26/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class VendorProfileVC: UIViewController,
UINavigationControllerDelegate, UITextFieldDelegate  {
    
    var ref: DatabaseReference!
    
    @IBOutlet var vendorImageBtn: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var vendorPhoneNumTextField: UITextField!
    @IBOutlet var vendorEmailTextField: UITextField!
    @IBOutlet var vendorLocationTextField: UITextField!
    @IBOutlet var storeNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard Auth.auth().currentUser != nil else {
            return
        }
    }

    @IBAction func profCancelBtn(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func profileSaveBtn(_ sender: Any) {
//        if storeNameTextField.text != nil {
//            AppUser.FirebaseKeys.name
//        } else {
//            errorAlert(message: "Not able to record name", from: self)
//            return
//        }
//        if vendorLocationTextField.text != nil {
//            AppUser.FirebaseKeys.addresses
//        } else {
//            errorAlert(message: "Not able to record location", from: self)
//            return
//        }
//        if vendorEmailTextField.text != nil {
//            AppUser.FirebaseKeys.email
//        } else {
//            errorAlert(message: "Not able to record email", from: self)
//            return
//        }
        
    }
   
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        AppUser.sharedInstance.logOut()
        self.performSegue(withIdentifier: "vendorProfileToLogin", sender: nil)
    }
    
    
}
