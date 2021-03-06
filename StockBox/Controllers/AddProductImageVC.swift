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
import FirebaseStorage
import AVFoundation
import Photos


class AddProductImageVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate  {
    
    @IBOutlet var segController: UISegmentedControl!
    @IBOutlet weak var reviewsBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var photoLibraryBtn: UIButton!
    @IBOutlet var addProductTitle: UITextField!
    @IBOutlet var prodctPrice: UITextField!
    @IBOutlet var productDescription: UITextView!
    @IBOutlet var imageDisplayed: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productImageURls = [String]()
    var currentProduct: Product?
    var pickedImages = [UIImage]()
    var picker = UIImagePickerController()
    var imagePicker: UIImagePickerController!
    
    var ref: DatabaseReference!
    
    @IBAction func addImageFromLibraryBtnPressed(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.imagePicker, animated: true, completion: nil)
        case .denied, .restricted :
            let deniedAlert = UIAlertController(title: "Denied Access", message: "Please go to setting and give StockBox permission to access your photo library", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            deniedAlert.addAction(okAction)
            
            // Present the controller
            self.present(deniedAlert, animated: true, completion: nil)
        case .notDetermined:
            let askAlert = UIAlertController(title: "Allow Photo Library Access", message: "Please allow photo library access, so that you can add images of your products", preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                PHPhotoLibrary.requestAuthorization() { status in
                    switch status {
                    case .authorized:
                        self.imagePicker.allowsEditing = true
                        self.imagePicker.sourceType = .photoLibrary
                        self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                        self.present(self.imagePicker, animated: true, completion: nil)
                    case .denied, .restricted:
                        messageAlert(title: "Denied Access", message: "You have denied Access to your photo library, Please go to settings and update the permisssions for Stockbox", from: self)
                    case .notDetermined:
                        print("the world is ending")
                    }
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            
            // Add the actions
            askAlert.addAction(okAction)
            askAlert.addAction(cancelAction)
            
            // Present the controller
            self.present(askAlert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
                case .authorized:
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                    self.imagePicker.cameraCaptureMode = .photo
                    self.imagePicker.modalPresentationStyle = .fullScreen
                    self.present(self.imagePicker, animated: true, completion: nil)
                case .denied, .restricted:
                    messageAlert(title: "Denied Access", message: "You have not allowed access to the Camera, Please go to setting to grant access from StockBox" , from: self)
                case .notDetermined:
                    let askCameraAlert = UIAlertController(title: "Allow Camera Access", message: "Please allow camera access, so that you can add images of your products", preferredStyle: .alert)
                    // Create the actions
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                            if granted {
                                self.imagePicker.allowsEditing = true
                                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                                self.imagePicker.cameraCaptureMode = .photo
                                self.imagePicker.modalPresentationStyle = .fullScreen
                                self.present(self.imagePicker, animated: true, completion: nil)
                            } else {
                            messageAlert(title: "Access Denied", message: "You have denied access to your Camera, Please go to setting to update Stockbox permissions", from: self)
                            }
                        })
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                        UIAlertAction in
                    }
                    askCameraAlert.addAction(okAction)
                    askCameraAlert.addAction(cancelAction)
                
                    // Present the controller
                    self.present(askCameraAlert, animated: true, completion: nil)
            }
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
        imagePicker.delegate = self
        picker.delegate = self
        addProductTitle.delegate = self
        prodctPrice.delegate = self
        ref = Database.database().reference()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        takePhotoBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        photoLibraryBtn.layer.cornerRadius = BUTTONCORNERRADIUS
        //reviewsBtn.layer.cornerRadius = BUTTONCORNERRADIUS
    }

//Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            print(image, "I am here")
            pickedImages.append(image)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           dismiss(animated:true, completion: nil)
        }
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
        let categoryChoice = segController.selectedSegmentIndex
        
        let image = #imageLiteral(resourceName: "quickadd")
        print(image, "THIS IS THE IMAGE I AM TALKING ABOUT")
        if let imageData = UIImageJPEGRepresentation(image, 0.2){
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            let storage = Storage.storage().reference()
            let productPhotos = storage.child("productPhotos")
            productPhotos.putData(imageData, metadata: metaData) { (metaData, error) in
                print("I GOT HERE")
            }
            
        }
        if currentProduct == nil {
            currentProduct = Product(name: title, price: priceAsDouble, description: description, vendorID: (AppUser.sharedInstance.currentUser?.uid)!, category: categoryChoice, imagesURLs: [])
            // was supposed to add to userInfo.products[]
        } else {
            currentProduct?.name = title
            currentProduct?.price = priceAsDouble
            currentProduct?.description_ = description
            currentProduct?.category = categoryChoice
        }
        
        for image in pickedImages {
            print(image, "This Got here")
            if let imageData = UIImageJPEGRepresentation(image, 0.2) {
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                let storage = Storage.storage().reference()
                let randomNum = arc4random()
                let photoID = storage.child("\(randomNum)")
                photoID.putData(imageData, metadata: metaData) { (metaData, error) in
                    if error != nil {
                        print("Unable to upload image")
                    } else {
                        print("Successful download")
                        let downloadUrl = metaData?.downloadURL()?.absoluteString
                        self.currentProduct!.appendImage(url: downloadUrl!)
                    }
                }
                
            }
        }
        dismiss(animated: true, completion: nil)
    }

//Segemented Category Controller
    
    @IBAction func changeCategory(_ sender: Any) {
        if segController.selectedSegmentIndex == 0 {
            //do something for spices
        }
        if segController.selectedSegmentIndex == 1 {
            //do something for herbs
        }
        if segController.selectedSegmentIndex == 2 {
            //do something for rubs
        }
        
    }
}

extension AddProductImageVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pickedImages.count == 0 {
            return 1
        } else {
        return pickedImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductImageVC", for: indexPath) as? VenderProductDetailCVCell else {
            fatalError("The World Is Ending")
        }
       
        cell.productImage.contentMode = .scaleAspectFit
        if pickedImages.count == 0 {
          cell.productImage.image = #imageLiteral(resourceName: "quickadd")
          return cell
        } else {
        cell.productImage.image = pickedImages[indexPath.row]
        return cell
        }
    }
    
    
    
}
