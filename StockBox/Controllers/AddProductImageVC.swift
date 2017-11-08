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
    @IBOutlet var imageDisplayed: UIImageView!
    
    var currentProdcut: Product?
    
    let picker = UIImagePickerController()
    
    var ref: DatabaseReference!
    
    
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
    }
    @IBAction func CancelProductInfoBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func SaveProductInfoBtn(_ sender: Any) {
        if currentProdcut == nil {
            
            guard let title = addProductTitle.text else {
                errorAlert(message: "Not able to record title", from: self)
                return
            }
            guard let price = prodctPrice.text else {
                errorAlert(message: "Not able to record price", from: self)
                return
            }
            guard let priceAsDouble = Double(price) else {
                errorAlert(message: "Please enter a number into price.", from: self)
                return
            }
            guard let description = productDescription.text else {
                errorAlert(message: "Not able to record description", from: self)
                return
            }
            currentProdcut = Product(name: title, price: priceAsDouble, description: description, vendorID: (AppUser.sharedInstance.currentUser?.uid)!, imagesURLs: [])
            dismiss(animated: true, completion: nil)
        }
        else {
            //use current object id
        }
    }
}
