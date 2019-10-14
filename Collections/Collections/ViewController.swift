//
//  CollectionViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 9/19/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log

class CollectionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK:  Properties
    
    //title
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleNameLabel: UILabel!
    //author
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var authorLabel: UILabel!
    //year
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var yearLabel: UILabel!
    //photo
    @IBOutlet weak var photoImageView: UIImageView!
    
    //save button
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var collection: Collection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        
        //set up views if editing an existing collection
        if let collection = collection{
            navigationItem.title = collection.title
            nameTextField.text = collection.title
            authorTextField.text = collection.author
            yearTextField.text = "\(collection.year)"
            photoImageView.image = collection.photo
        }
        
        //Enable the save button only if the text field has a valid name
        updateSaveButtonState()
        
    }

    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        //Disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) ->Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerCOntrollerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as?
            UIImage else{
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddCollectionMode = presentingViewController is UINavigationController
        
        if isPresentingInAddCollectionMode{
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The CollectionViewController is not inside a navigation controller.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = nameTextField.text ?? ""
        let author = authorTextField.text ?? ""
        let photo = photoImageView.image
        let year = Int(yearTextField.text!)
        
        collection = Collection(title: title, author: author, year: year!, photo: photo)
        
    }
    
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        let text = nameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
    }
    
}

