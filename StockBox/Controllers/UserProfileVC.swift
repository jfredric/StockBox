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
        
        if currentAppUser.currentUser != nil {
            if currentAppUser.name != "" {
                nameTextField.text = currentAppUser.name
            }
            accountBalanceLabel.text = doubleToCurrencyString(value: currentAppUser.balance)
            if let email = currentAppUser.currentUser?.email {
                emailLabel.text = email
            } else {
                emailLabel.text = "none"
            }
        
            updateAddressViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
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
        editAddressTitleLabel.text = "Edit Address"
    }
    
    @IBAction func billingAddressEditBtnPressed(_ sender: Any) {
        editAddressView.isHidden = false
        editingShipping = false
        editAddressTitleLabel.text = "Edit Address"
    }
    
    @IBAction func doneEditingAddressBtnPressed(_ sender: UIButton) {
        
        // if empty fields, then do not save
        if !validTextFields() {
            return
        }
        
        // read the text fields
        if editingShipping {
            if currentAppUser.addresses.count == 0 {
                // create new address(s)
                guard let newAddress = saveAddressChangesFromTextFields(currentAddress: nil) else {
                    return
                }
                // we are currently linking the billing and shipping addresses store in addresses [0] and [1]
                currentAppUser.appendAddress(newAddress: newAddress) // shipping
                currentAppUser.appendAddress(newAddress: newAddress) // billing
                updateAddressViews()
            } else {
                // modify address
                // we are currently linking the billing and shipping addresses store in addresses [0] and [1]
                saveAddressChangesFromTextFields(currentAddress: currentAppUser.addresses[0]) // shipping
                saveAddressChangesFromTextFields(currentAddress: currentAppUser.addresses[1]) // billing
                updateAddressViews()
            }
        } else { // currently not needed to do separately...but coded for later update
            if currentAppUser.addresses.count == 0 {
                // create new address(s)
                guard let newAddress = saveAddressChangesFromTextFields(currentAddress: nil) else {
                    return
                }
                // we are currently linking the billing and shipping addresses store in addresses [0] and [1]
                currentAppUser.appendAddress(newAddress: newAddress) // shipping
                currentAppUser.appendAddress(newAddress: newAddress) // billing
                updateAddressViews()
            } else {
                // modify address
                // modify address
                // we are currently linking the billing and shipping addresses store in addresses [0] and [1]
                saveAddressChangesFromTextFields(currentAddress: currentAppUser.addresses[0]) // shipping
                saveAddressChangesFromTextFields(currentAddress: currentAppUser.addresses[1]) // billing
                updateAddressViews()
            }
        }
        
        // only dismiss if valid input is received. Cancel needed?
        recipientTextField.becomeFirstResponder() // hack it until you make it...
        recipientTextField.resignFirstResponder() // make sure keyboard is dismissed
        editAddressView.isHidden = true
    }
    
    @IBAction func emailChangeBtnPressed(_ sender: UIButton) {
        messageAlert(title: "Notice", message: "upating email is not currently supported.", from: self)
    }
    
    @IBAction func passwordChangeBtnPressed(_ sender: Any) {
        messageAlert(title: "Notice", message: "upating password is not currently supported.", from: self)
    }
    
    @IBAction func logInOutBtnPressed(_ sender: Any) {
        AppUser.sharedInstance.logOut()
    }
    
    // MARK: PRIVATE FUNCTIONS
    
    private func validTextFields() -> Bool {
        if recipientTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for recipient.", from: self)
            return false
        }
        if addressLineTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for address line.", from: self)
            return false
        }
        if cityTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for city.", from: self)
            return false
        }
        if stateTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for state.", from: self)
            return false
        }
        if zipTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for zipcode.", from: self)
            return false
        }
        if countryTextField.text! == "" {
            messageAlert(title: "Invalid Input", message: "Input needed for country.", from: self)
            return false
        }
        return true
    }
    
    private func updateAddressViews() {
        // currently linking both addresses together.
        if currentAppUser.addresses.count > 0 {
            shippingAddressTextView.text = currentAppUser.addresses[0].toText()
            billingAddressTextView.text = currentAppUser.addresses[1].toText()
        } else {
            shippingAddressTextView.text = "\n\naddress info needed"
            billingAddressTextView.text = "\n\naddress info needed"
        }
    }
    
    // if this is a new address then pass in nil
    private func saveAddressChangesFromTextFields(currentAddress: Address?) -> Address? {
        // get and trim text values of text fields
        let recipient = stringTrimmer(stringToTrim: recipientTextField.text!)!
        let street = stringTrimmer(stringToTrim: addressLineTextField.text!)!
        var unit = stringTrimmer(stringToTrim: unitTextField.text!)
        if unit! == "" {
            unit = nil
        }
        let city = stringTrimmer(stringToTrim: cityTextField.text!)!
        let state = stringTrimmer(stringToTrim: stateTextField.text!)!
        let zip = stringTrimmer(stringToTrim: zipTextField.text!)!
        let country = stringTrimmer(stringToTrim: countryTextField.text!)!
        
        if currentAddress == nil {
            return Address(recipient: recipient, street: street, unit: unit, city: city, state: state, zipcode: zip, country: country)
        } else {
            if recipient != currentAddress!.recipient {
                currentAddress!.recipient = recipient
            }
            if street != currentAddress!.street {
                currentAddress!.street = street
            }
            if unit != currentAddress!.unit {
                currentAddress!.unit = unit
            }
            if city != currentAddress!.city {
                currentAddress!.city = city
            }
            if state != currentAddress!.state {
                currentAddress!.state = state
            }
            if recipient != currentAddress!.recipient {
                currentAddress!.recipient = recipient
            }
            if recipient != currentAddress!.recipient {
                currentAddress!.recipient = recipient
            }
            return nil
        }
    }
    
    // MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LoginVC {
            //print("segueing to login")
        }
    }
    

}
