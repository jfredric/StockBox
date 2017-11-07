//
//  ViewController.swift
//  StockBox
//
//  Created by Stockbox team on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var browseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Set the TextField Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        // had to remove. Was causing crashing once moved to separate storyboard.
        
        // change browse button text color to secondary here.
        
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = BUTTONCORNERRADIUS
        emailTextField.layer.masksToBounds = true
        let attributedString = NSAttributedString(string: "Enter Email",
                                                  attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDERTEXTCOLOR])
        loginBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        signupBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        
        
        emailTextField.attributedPlaceholder = attributedString
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = BUTTONCORNERRADIUS
        passwordTextField.layer.masksToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDERTEXTCOLOR])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        /*    if user != nil {
                // user is logged in
                if AppUser.sharedInstance.account == AppUser.AccountType.consumer {
                    // go back to previous view
                    print("Log [LoginVC]: User is logged in (observer)")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Log [LoginVC]: Vendor logged in (observer)")
                    self.performSegue(withIdentifier: "loginToVendorSegue", sender: self)
                }
            }*/
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    // MARK: TEXTFIELD DELEGATE FUNCTIONS

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField{
            textField.resignFirstResponder()
        }
        return true
    }

    // MARK: ACTION FUNCTIONS

    @IBAction func browseButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginToUserHomeSegue", sender: self)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {

        if ConnectionCheck.isConnectedToNetwork() {
            // Look in utility file for trimmedAndUnwrappedUserPass func
            let unWrappedCleanedStrings = trimmedAndUnwrappedTextFieldInputs(email: emailTextField.text, password: passwordTextField.text)
            // Look below in utility section for textFeildErrorHandling func
            let isvalid = textFieldErrorHandling(emailString: unWrappedCleanedStrings.0, passString: unWrappedCleanedStrings.1)
            if isvalid {
                AppUser.sharedInstance.login(username: unWrappedCleanedStrings.0, password: unWrappedCleanedStrings.1, completion: { (error) in
                    if error == nil {
                        switch AppUser.sharedInstance.account {
                        case .vendor :
                            self.performSegue(withIdentifier: "loginToVendorSegue", sender: self)
                        case .consumer :
                            self.performSegue(withIdentifier: "loginToUserHomeSegue", sender: self)
                        default:
                            fatalErrorAlert(message: "Unexpected account type", from: self)
                            return
                        }
                    }
                })
            }
        } else {
            let internetConnectionAlert = loginAuthAlertMaker(alertTitle: "Internet Access Required", alertMessage: "In order to properly encript and protect your information during login internet access is required./n Please reconnect and try again")
            self.present(internetConnectionAlert, animated: true, completion: nil)
        }
    }

    //MARK: UTILITY FUNC'S FOR LOGINVC
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
