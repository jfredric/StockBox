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
//    @IBOutlet var vendorImageBtn: UIButton!
//    @IBOutlet var descriptionTextView: UITextView!
//    @IBOutlet var vendorPhoneNumTextField: UITextField!
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

    @IBAction func profileSaveBtn(_ sender: Any) {

        // Dismiss keyboard hack
        storeNameTextField.becomeFirstResponder()
        storeNameTextField.resignFirstResponder()
        
        //Store name Text Field
        if storeNameTextField.text != nil {
            AppUser.sharedInstance.name = storeNameTextField.text!
            if AppUser.sharedInstance.addresses.count > 0 {
                AppUser.sharedInstance.addresses[0].recipient = vendorLocationTextField.text!
            } else {
                let newAddress = Address(recipient: vendorLocationTextField.text!, street: "", unit: nil, city: "", state: "", zipcode: "", country: "")
                AppUser.sharedInstance.appendAddress(newAddress: newAddress)
            }
        } else {
            errorAlert(message: "Not able to record name", from: self)
            return
        }

        //City Text Field
        if vendorLocationTextField.text != nil {
            if AppUser.sharedInstance.addresses.count > 0 {
                AppUser.sharedInstance.addresses[0].city = vendorLocationTextField.text!
            } else {
                let newAddress = Address(recipient: "", street: "", unit: nil, city: vendorLocationTextField.text!, state: "", zipcode: "", country: "")
                AppUser.sharedInstance.appendAddress(newAddress: newAddress)
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
                let newAddress = Address(recipient: "", street: "", unit: nil, city: "", state: "", zipcode: "", country: vendorCountryTextField.text!)
                AppUser.sharedInstance.appendAddress(newAddress: newAddress)
            }
        } else {
            errorAlert(message: "Not able to record country", from: self)
            return
        }

        // Email - change username
        if vendorEmailTextField.text != nil {
           // call the change email/username once implemented
        } else {
            errorAlert(message: "Not able to record email", from: self)
            return
        }
        
        
        messageAlert(title: "Profile Saved", message: "Your profile information has been saved.", from: self)
    }

    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        AppUser.sharedInstance.logOut()
        self.performSegue(withIdentifier: "vendorProfileToLogin", sender: nil)
    }

}
