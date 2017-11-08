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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var shippingAddressTextView: UITextView!
    @IBOutlet weak var billingAddressTextView: UITextView!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // if user is not logged in, should not be here. Throw error?
        if AppUser.sharedInstance.name != "" {
            nameTextField.text = AppUser.sharedInstance.name
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
    
    // MARK: TEXTFIELD DELEGATE FUNCTIONS
    
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
        return true
    }
    
    // MARK: ACTION FUNCTIONS
    
    @IBAction func shippingAddressEditBtnPressed(_ sender: Any) {
    }
    
    @IBAction func billingAddressEditBtnPressed(_ sender: Any) {
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
