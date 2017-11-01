//
//  AddProductImageVC.swift
//  StockBox
//
//  Created by Grishma Athavale on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class AddProductImageVC: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {

    let picker = UIImagePickerController()
    
    @IBOutlet var imageDisplayed: UIImageView!
    
    @IBAction func addPhotoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
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
    }

//Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageDisplayed.contentMode = .scaleAspectFit
        imageDisplayed.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

