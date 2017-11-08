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
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentProdcut: Product?
    
    var picker = UIImagePickerController()
    var imagePicker: UIImagePickerController!
    
    var ref: DatabaseReference!
    @IBAction func addImageFromLibraryBtnPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let askAlert = UIAlertController(title: "Allow Photo Library Access", message: "Please allow photo library access, so that you can add images of your products", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            askAlert.addAction(okAction)
            askAlert.addAction(cancelAction)
            
            // Present the controller
            self.present(askAlert, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let askAlert = UIAlertController(title: "Allow Camera Access", message: "Please allow camera access, so that you can add images of your products", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.imagePicker.allowsEditing = true
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            askAlert.addAction(okAction)
            askAlert.addAction(cancelAction)
            
            // Present the controller
            self.present(askAlert, animated: true, completion: nil)
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
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        picker.delegate = self
        addProductTitle.delegate = self
        prodctPrice.delegate = self
        ref = Database.database().reference()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

//Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        imagePicker.dismiss(animated: true, completion: nil)
//        if case let info[UIImagePickerControllerEditedImage] as? UIImage{
//
//        }
//        var  chosenImage = UIImage()
//        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        imageDisplayed.contentMode = .scaleAspectFit
//        imageDisplayed.image = chosenImage
//        dismiss(animated:true)
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

extension AddProductImageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductImageVC", for: indexPath) as? VenderProductDetailCVCell else {
            fatalError("The World Is Ending")
        }
        
        return cell
    }
    
    
}
