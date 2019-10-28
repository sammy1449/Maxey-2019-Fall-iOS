//
//  CollectionsNameViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log

class CollectionsNameViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var collectionNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var name: CollectionName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionNameTextField.delegate = self
        
        if let name = name{
            navigationItem.title = name.name
            collectionNameTextField.text = name.name
        }
        
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        collectionNameLabel.text = "Collection Name"
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    
    
    // MARK: - Navigation

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddCollectionNameMode = presentingViewController is UINavigationController
        if isPresentingInAddCollectionNameMode{
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The CollectionNameViewController is not inside a navigation controller.")
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let cName = collectionNameTextField.text ?? ""
        
        name = CollectionName(name: cName)
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        let text = collectionNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    

}
