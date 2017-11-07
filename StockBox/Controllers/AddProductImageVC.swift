//
//  AddProductImageVC.swift
//  StockBox
//
//  Created by Grishma Athavale on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddProductImageVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate  {
    
    @IBOutlet var addProductTitle: UITextField!
    
    @IBOutlet var prodctPrice: UITextField!
    
    @IBOutlet var productDescription: UITextView!
    
    let picker = UIImagePickerController()
    
    var ref: DatabaseReference!
    
    @IBOutlet var imageDisplayed: UIImageView!
    
    @IBAction func addPhotoButton(_ sender: Any) {
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
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        addProductTitle.delegate = self
        prodctPrice.delegate = self
        ref = Database.database().reference()
    }

//Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageDisplayed.contentMode = .scaleAspectFit
        imageDisplayed.image = chosenImage
        dismiss(animated:true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        if textField == addProductTitle {
            prodctPrice.becomeFirstResponder()
        }
        if textField == productDescription{
            textField.resignFirstResponder()
        }
        return true
        }
    

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        let uid = user.uid
        
        if let title = addProductTitle.text {
            self.ref.child("users").child(uid).setValue(["title": title])
        }
        if let price = prodctPrice.text {
            self.ref.child("users").child(uid).setValue(["price": price])
        }
        if let description = productDescription.text {
            self.ref.child("users").child(uid).setValue(["description": description])
        }
    }

}
