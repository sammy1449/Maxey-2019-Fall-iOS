//
//  CollectionController.swift
//  Collections
//
//  Created by Samantha Maxey on 12/5/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import CoreData

class CollectionController: NSObject {

    static var collectionArray:Array<MediaType> = []
    static var context = DatabaseController.persistentContainer?.viewContext
    
    class func addNewCollection(newCollection:MediaType){
        CollectionController.collectionArray.append(newCollection)
        do {
            try context?.save()
               print("Success")
           } catch {
               print("Error saving: \(error)")
           }
        
    }
    
    class func removeCollection(atIndex: Int){
        CollectionController.collectionArray.remove(at: atIndex)
        do {
               try context?.save()
               print("Success")
           } catch {
               print("Error saving: \(error)")
           }
    }
    
    class func addToCollection(){
        
    }
}
