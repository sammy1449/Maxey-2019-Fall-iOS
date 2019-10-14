//
//  CollectionNameViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class CollectionNameViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var collectionsNameTextField: UITextField!
    
    var name: collectionName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsNameTextField.delegate = self
        
        if let name = name{navigationItem.title = name.name
            collectionsNameTextField.text = name.name
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        collectionNameLabel.text = textField.text
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
