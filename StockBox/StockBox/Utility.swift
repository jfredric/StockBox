//
//  Utility.swift
//  StockBox
//
//  Created by Jared Sobol on 10/24/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import Foundation
import UIKit

// removes empty space from user inputs
func stringTrimmer(stringToTrim string: String?) -> String? {
    let trimmedString = string?.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmedString
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
    let trimmedEmail = stringTrimmer(stringToTrim: email)
    let trimmedPassword = stringTrimmer(stringToTrim: password)
    guard let unwrappedTrimmedEmail = trimmedEmail else {return ("","")}
    guard let unwrappedTrimmedPassword = trimmedPassword else {return ("","")}
    return (unwrappedTrimmedEmail, unwrappedTrimmedPassword)
}
