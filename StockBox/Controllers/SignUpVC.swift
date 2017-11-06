//
//  SignUpVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var UserMerchantSegmentControl: UISegmentedControl!

    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the TextField Delegate's
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        emailTextField.layer.borderColor = MAINORANGECOLOR.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.masksToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter Email",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: MAINORANGECOLOR])
        popUpView.layer.cornerRadius = BUTTONCORNERRADIUS
        signUpBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        passwordTextField.layer.borderColor = MAINORANGECOLOR.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.masksToBounds = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: MAINORANGECOLOR])


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

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

    @IBAction func signUpBtnPressed(_ sender: Any) {
        if ConnectionCheck.isConnectedToNetwork() {
            
            // read the account type from the segment controller.
            var accountType: AppUser.AccountType
            switch UserMerchantSegmentControl.selectedSegmentIndex {
            case 0:
                accountType = .vendor
            case 1:
                accountType = .consumer
            default:
                accountType = .consumer // compiler complains about not guaranteeing initilalization of variable
                fatalErrorAlert(message: "Segment Controller in invalid state", from: self)
            }
            
            let unWrappedCleanedStrings = trimmedAndUnwrappedTextFieldInputs(email: emailTextField.text, password: passwordTextField.text)
            let isvalid = textFieldErrorHandling(emailString: unWrappedCleanedStrings.0, passString: unWrappedCleanedStrings.1)
            if isvalid {
                // Give user singleton the username, password and account type to attempt to create new account
                AppUser.sharedInstance.signUp(username: unWrappedCleanedStrings.0, password: unWrappedCleanedStrings.1, accountType: accountType, completion: { (error) in
                    if let error = error {
                        // inform user of failure message. Do nothing else. Letting user try again or backout
                        messageAlert(title: "Sign-Up Failed", message: error.localizedDescription, from: self)
                    }
                    else {
                        // sign up successful, return to login page so that it may dismiss itself as well.
                        print("Log [SignUpVC]: User sign-up successfull, dismissing view")
                        switch accountType {
                        case .vendor :
                            self.performSegue(withIdentifier: "signUpToVendorSegue", sender: self)
                        case .consumer :
                            self.performSegue(withIdentifier: "signUpToUserHomeSegue", sender: self)
                        default:
                            fatalErrorAlert(message: "Unexpected account type", from: self)
                            return
                        }
                    }
                })
            }
        } else {
            let internetConnectionAlert = loginAuthAlertMaker(alertTitle: "Internet Access Required", alertMessage: "In order to properly encript and protect your information during Sign Up internet access is required./n Please reconnect and try again")
            self.present(internetConnectionAlert, animated: true, completion: nil)
        }
    }

    //UTILITY FUNCS FOR SignUpVC
    //*************************
    //Checks in either field is empty and alerts with apporpriate response
    func textFieldErrorHandling(emailString: String, passString: String) -> Bool {
        let stringTuple = (emailString, passString)
        switch stringTuple {
        case (let x, let y) where x.isEmpty && y.isEmpty:
            let emptyEmailAndPassAlert = loginAuthAlertMaker(alertTitle: "Empty Email & Password", alertMessage: "Please enter an Email & Password")
            self.present(emptyEmailAndPassAlert, animated: true, completion: nil)
            return false
        case (let x,_) where x.isEmpty:
            let emptyEmailAlert = loginAuthAlertMaker(alertTitle: "Empty Email", alertMessage: "Please enter a valid Email")
            self.present(emptyEmailAlert, animated: true, completion: nil)
            return false
        case (_, let y) where y.isEmpty:
            let emptyPasswordAlert = loginAuthAlertMaker(alertTitle: "Empty Password", alertMessage: "Please enter a valid Password")
            self.present(emptyPasswordAlert, animated: true, completion: nil)
            return false
        default:
            return true
        }
    }




}
