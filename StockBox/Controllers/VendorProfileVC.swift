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

class VendorProfileVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate  {

    let picker = UIImagePickerController()
    
    var ref: DatabaseReference!
    


    @IBOutlet var vendorImageBtn: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var vendorPhoneNumTextField: UITextField!
    @IBOutlet var vendorEmailTextField: UITextField!
    @IBOutlet var vendorLocationTextField: UITextField!
    @IBOutlet var storeNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let user = Auth.auth().currentUser else {
            return 
        }
        let uid = user.uid
        
        if let description = descriptionTextView.text {
            self.ref.child("users").child(uid).setValue(["description": description])
        }
        if let storeName = storeNameTextField.text {
            self.ref.child("users").child(uid).setValue(["store name": storeName])
        }
        if let location = vendorLocationTextField.text {
             self.ref.child("users").child(uid).setValue(["location": location])
        }
        if let phoneNum = vendorPhoneNumTextField.text {
            self.ref.child("users").child(uid).setValue(["phone number": phoneNum])
        }
        if let email = vendorEmailTextField.text {
            self.ref.child("users").child(uid).setValue(["email": email])
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        AppUser.sharedInstance.logOut()
        self.performSegue(withIdentifier: "vendorProfileToLogin", sender: nil)
    }
    
    @IBAction func vendorImagePress(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device cannot use the camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Okay",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true)
    }
    
//Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        vendorImageBtn.contentMode = .scaleAspectFit
        vendorImageBtn.imageView?.image = chosenImage
        dismiss(animated:true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
