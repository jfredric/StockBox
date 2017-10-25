//
//  ViewController.swift
//  StockBox
//
//  Created by Jared Sobol on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("we are good")
            // Look in utility file for trimmedAndUnwrappedUserPass func
            let unWrappedCleanedStrings = trimmedAndUnwrappedTextFieldInputs(email: emailTextField.text, password: passwordTextField.text)
            // Look below in utility section for textFeildErrorHandling func
            let isvalid = textFieldErrorHandling(emailString: unWrappedCleanedStrings.0, passString: unWrappedCleanedStrings.1)
            if isvalid {
                Auth.auth().signIn(withEmail: unWrappedCleanedStrings.0, password: unWrappedCleanedStrings.1) { (user, error) in
                    if let error = error {
                        let authAlert = loginAuthAlertMaker(alertTitle: "Invalid Entry", alertMessage: error.localizedDescription)
                        self.present(authAlert, animated: true, completion: nil)
                        return
                    }
                    print("logged In")
                    //                self.navigationController!.popViewController(animated: true)
                }
            }
        } else {
            let internetConnectionAlert = loginAuthAlertMaker(alertTitle: "Internet Access Required", alertMessage: "In order to properly encript and protect your information during login internet access is required./n Please reconnect and try again")
            self.present(internetConnectionAlert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func SignUpBtnPressed(_ sender: Any) {
        
    }
    
    
    //UTILITY FUNCS FOR LOGINVC
    //*************************
    //Checks in either field is empty and alerts with apporpriate response
    func textFieldErrorHandling(emailString: String, passString: String) -> Bool {
        let stringTuple = (emailString, passString)
        switch stringTuple {
        case (let x, let y) where x.isEmpty && y.isEmpty:
            let emptyEmailAndPassAlert = loginAuthAlertMaker(alertTitle: "Empty Email & Password", alertMessage: "Please enter your Email & Password")
            self.present(emptyEmailAndPassAlert, animated: true, completion: nil)
            return false
        case (let x,_) where x.isEmpty:
            let emptyEmailAlert = loginAuthAlertMaker(alertTitle: "Empty Email", alertMessage: "Please enter your Email")
            self.present(emptyEmailAlert, animated: true, completion: nil)
            return false
        case (_, let y) where y.isEmpty:
            let emptyPasswordAlert = loginAuthAlertMaker(alertTitle: "Empty Password", alertMessage: "Please enter your Password")
            self.present(emptyPasswordAlert, animated: true, completion: nil)
            return false
        default:
            return true
        }
    }
}

