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
    
    @IBOutlet var vendorCountryTextField: UITextField!
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
        if storeNameTextField.text != nil {
            AppUser.sharedInstance.name = storeNameTextField.text!
        } else {
            errorAlert(message: "Not able to record name", from: self)
            return
        }
        
        //City Text Field
        
        if vendorLocationTextField.text != nil {
            
            if AppUser.sharedInstance.addresses.count > 0 {
                AppUser.sharedInstance.addresses[0].city = vendorLocationTextField.text!
            } else {
               // let newAddress = Address(id: "", recipient: "", street: "", unit: "", city: vendorLocationTextField, state: "", zipcode: "", country: "")
            }
        } else {
            errorAlert(message: "Not able to record city", from: self)
            return
        }
        
        //Country Text Field
        if vendorCountryTextField.text != nil {
            if AppUser.sharedInstance.addresses.count > 0 {
                AppUser.sharedInstance.addresses[0].country = vendorCountryTextField.text!
            } else {
              // let newAddress = Address(id: "", recipient: "", street: "", unit: "", city: "", state: "", zipcode: "", country: vendorCountryTextField)
            }
        } else {
            errorAlert(message: "Not able to record country", from: self)
            return
        }
        
            
            // Email
        if vendorEmailTextField.text != nil {
           // AppUser.sharedInstance.email =  vendorEmailTextField.text
            }
        else {
            errorAlert(message: "Not able to record email", from: self)
            return
        }
        
    }
   
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        AppUser.sharedInstance.logOut()
        self.performSegue(withIdentifier: "vendorProfileToLogin", sender: nil)
    }

}

