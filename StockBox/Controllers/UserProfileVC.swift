//
//  UserLogOutVC.swift
//  StockBox
//
//  Created by Jared Sobol on 11/1/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var shippingAddressTextField: UITextField!
    @IBOutlet weak var billingAddressTextField: UITextField!
    @IBOutlet weak var accountBalanceTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // if user is not logged in, should not be here. Throw error?
        print("view loaded")
    }
    
    override func viewWillAppear(_ animated: Bool) { // this might cause a loop if user does not log in...
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is logged in
                // set the tab bar icon
            } else {
                // user is not logged in
                // set the tab bar icon
                // segue to login
                self.performSegue(withIdentifier: "userProfileToLoginSegue", sender: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: ACTION FUNCTIONS
    @IBAction func nameEditBtnPressed(_ sender: Any) {
    }
  
    @IBAction func shippingAddressEditBtnPressed(_ sender: Any) {
    }
    @IBAction func billingAddressEditBtnPressed(_ sender: Any) {
    }
    
    @IBAction func passwordEditBtnPressed(_ sender: Any) {
    }
    @IBAction func logInOutBtnPressed(_ sender: Any) {
        AppUser.sharedInstance.logOut()
        // update view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LoginVC {
            print("segueing to login")
        }
    }
    

}
