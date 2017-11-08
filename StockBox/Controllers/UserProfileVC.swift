//
//  UserProfileVC.swift
//  StockBox
//
//  Created by Jared Sobol on 11/1/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController, UITextFieldDelegate {
    
    // MARK: OUTLETS
    
    // Primary View Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var shippingAddressTextView: UITextView!
    @IBOutlet weak var billingAddressTextView: UITextView!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var editAddressView: UIView!
    @IBOutlet weak var shipEditButton: UIButton!
    @IBOutlet weak var billEditButton: UIButton!
    
    // Edit Address View Outlets
    @IBOutlet weak var editAddressTitleLabel: UILabel!
    @IBOutlet weak var recipientTextField: UITextField!
    @IBOutlet weak var addressLineTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    // MARK: PROPERTIES
    var handle: AuthStateDidChangeListenerHandle?
    var currentAppUser: AppUser!
    var editingShipping = false
    
    // MARK: VIEW DELEGATE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // if user is not logged in, should not be here. Throw error?
        
        currentAppUser = AppUser.sharedInstance
        nameTextField.delegate = self
        recipientTextField.delegate = self
        addressLineTextField.delegate = self
        unitTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipTextField.delegate = self
        countryTextField.delegate = self
        
        if currentAppUser.name != "" {
            nameTextField.text = currentAppUser.name
        }
        accountBalanceLabel.text = doubleToCurrencyString(value: currentAppUser.balance)
        if let email = currentAppUser.currentUser?.email {
            emailLabel.text = email
        } else {
            emailLabel.text = "none"
        }
        
        if currentAppUser.addresses.count > 0 {
            shippingAddressTextView.text = currentAppUser.addresses[0].toText()
        } else {
            shippingAddressTextView.text = "\n\naddress info needed"
        }
        if currentAppUser.addresses.count > 1 {
            billingAddressTextView.text = currentAppUser.addresses[1].toText()
        } else {
            billingAddressTextView.text = "\n\naddress info needed"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
                // user is logged in
                // set the tab bar icon
//                let profileTabBarItem: UITabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-tab"), selectedImage: UIImage(named: "profile-tab"))
//                self.tabBarItem = profileTabBarItem
            } else {
                // user is not logged in
                // set the tab bar icon
//                let loginTabBarItem: UITabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "login-tab"), selectedImage: UIImage(named: "login-tab"))
//                self.tabBarItem = loginTabBarItem
                
                // segue to login view
                self.performSegue(withIdentifier: "userProfileToLoginSegue", sender: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: TEXTFIELD DELEGATE
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            // save name
            if let newName = textField.text {
                // only save the name if it has changed
                if newName != AppUser.sharedInstance.name {
                    AppUser.sharedInstance.name = newName
                }
            }
            // dismiss keyboard
            textField.resignFirstResponder()
        }
        
        // edit view - text field chaining
        switch textField {
        case recipientTextField :
            addressLineTextField.becomeFirstResponder()
        case addressLineTextField :
            unitTextField.becomeFirstResponder()
        case unitTextField :
            cityTextField.becomeFirstResponder()
        case cityTextField :
            stateTextField.becomeFirstResponder()
        case stateTextField :
            zipTextField.becomeFirstResponder()
        case zipTextField :
            countryTextField.becomeFirstResponder()
        default :
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: ACTION FUNCTIONS
    
    @IBAction func shippingAddressEditBtnPressed(_ sender: Any) {
        editAddressView.isHidden = false
        editingShipping = true
        editAddressTitleLabel.text = "Edit Shipping Address"
    }
    
    @IBAction func billingAddressEditBtnPressed(_ sender: Any) {
        editAddressView.isHidden = false
        editingShipping = false
        editAddressTitleLabel.text = "Edit Billing Address"
    }
    
    @IBAction func doneEditingAddressBtnPressed(_ sender: UIButton) {
        // read the text fields
        if editingShipping {
            
        } else {
            
        }
        recipientTextField.becomeFirstResponder() // hack it until you make it...
        recipientTextField.resignFirstResponder() // make sure keyboard is dismissed
        editAddressView.isHidden = true
    }
    
    @IBAction func emailChangeBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func passwordChangeBtnPressed(_ sender: Any) {
    }
    
    @IBAction func logInOutBtnPressed(_ sender: Any) {
        AppUser.sharedInstance.logOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LoginVC {
            //print("segueing to login")
        }
    }
    

}
