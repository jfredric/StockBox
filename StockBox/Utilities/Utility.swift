//
//  Utility.swift
//  StockBox
//
//  Created by Jared Sobol on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import UIKit

// MARK: STRING FORMATING FUNCTIONS
// removes empty space from user inputs
func stringTrimmer(stringToTrim string: String?) -> String? {
    let trimmedString = string?.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmedString
}

// converts a double to a String of Format '$0.00'
func doubleToCurrencyString(value: Double) -> String {
    return String(format: "$%.02f", value)
}

// MARK: ALERTS

// allows you to get the topmost view at any current time
extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

// send user a message
func messageAlert(title: String, message: String?, from: UIViewController?) {
    
    // Create the Alert Controller
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    // add the button actions - Left to right
    //    OK Button
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    // Present the Alert
    
    (from ?? UIApplication.topViewController()!).present(alertController, animated: true, completion: nil)
}

// send user an error message
func errorAlert(message: String?, from: UIViewController?) {
    // Create the Alert Controller
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
    // add the button actions - Left to right
    //    OK Button
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    // Present the Alert
    (from ?? UIApplication.topViewController()!).present(alertController, animated: true, completion: nil)
}

// send user an error message
func fatalErrorAlert(message: String?, from: UIViewController?) {
    // Create the Alert Controller
    let alertController = UIAlertController(title: "Fatal Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
    // add the button actions - Left to right
    //    OK Button
    let crashAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (alertAction) in
        fatalError(message!)
    }
    alertController.addAction(crashAction)
    
    // Present the Alert
    (from ?? UIApplication.topViewController()!).present(alertController, animated: true, completion: nil)
}

// sets up basic alerts
func loginAuthAlertMaker(alertTitle: String, alertMessage: String) -> UIAlertController {
    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
    return alert
}
// unswrapps trimmed optional Strings
func trimmedAndUnwrappedTextFieldInputs(email: String?, password: String?) -> (String,String) {
    //look in Utility file for stringTrimmer Func
    let unwrappedTrimmedEmail = stringTrimmer(stringToTrim: email) ?? ""
    let unwrappedTrimmedPassword = stringTrimmer(stringToTrim: password) ?? ""
    return (unwrappedTrimmedEmail, unwrappedTrimmedPassword)
}
