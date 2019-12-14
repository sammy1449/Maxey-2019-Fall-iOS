//
//  CollectionNameTableViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log
import CoreData

class CollectionNameTableViewController: UITableViewController {
    
    //MARK: Properties
    
   // var names = [CollectionName]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //DatabaseController.saveContext()
        
//        let fetchRequest:NSFetchRequest = MediaType.fetchRequest()
//
//        do{
//            fetchResult = try DatabaseController.persistentStoreContainer().viewContext.fetch(fetchRequest)
//        }catch{
//            print(error)
//        }
//
        navigationItem.leftBarButtonItem = editButtonItem
//        if let savedCollectionNames = loadCollectionNames(){
//            names += savedCollectionNames
//        }
      
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CollectionController.collectionArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CollectionNameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CollectionNameTableViewCell else{
            fatalError("The dequeued cell is not an instance of CollectionNameTableViewCell.")
        }
        
        //let name = names[indexPath.row]
       // cell.collectionNameLabel.text = CollectionController.collectionArray[indexPath.row]

        // Configure the cell...
        return cell
        
    }
 
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           // names.remove(at: indexPath.row)
            CollectionController.removeCollection(atIndex: indexPath.row)
            //saveCollectionNames()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//        switch(segue.identifier ?? ""){
//        case "AddName":
//            os_log("Adding a new name.", log: OSLog.default, type: .debug)
//
//        case "ShowDetail1":
//            guard let collectionNameDetailViewController = segue.destination as? CollectionsNameViewController else{
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//
//            guard let selectedCollectioNameCell = sender as? CollectionNameTableViewCell else{
//                    fatalError("Unexpected sender: \(sender)")
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedCollectioNameCell)else{
//                        fatalError("The selected cell is not being displayed by the table")
//                }
//
//                let selectedCollectionName = names[indexPath.row]
//
//                collectionNameDetailViewController.name = selectedCollectionName
//
//        default:
//            fatalError("Unexpected Segue Identifier: \(segue.identifier)")
//            }
//
//    }
//
//
//
//    //MARK: Actions
//    @IBAction func unwindToCollectionNameList(sender: UIStoryboardSegue){
//        if let sourceViewController = sender.source as? CollectionsNameViewController, let name = sourceViewController.name{
//            if let selectedIndexPath = tableView.indexPathForSelectedRow{
//                names[selectedIndexPath.row] = name
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            }else{
//
//                let newIndexPath = IndexPath(row: names.count, section: 0)
//
//                names.append(name)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
//            saveCollectionNames()
//        }
//    }
//
//    //MARK: Private Methods
//
//    private func loadSampleCollection(){
//        let collection1 = CollectionName(name: "Books")!
//        let collection2 = CollectionName(name: "Movies")!
//
//        names += [collection1, collection2]
//    }
//
//    private func saveCollectionNames(){
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(names, toFile: CollectionName.ArchiveURL.path)
//
//        if isSuccessfulSave{
//            os_log("Collection names successfully saved.", log: OSLog.default, type: .debug)
//        }else{
//            os_log("Failed to save collection names...", log: OSLog.default, type: .error)
//        }
//    }
//
//    private func loadCollectionNames() -> [CollectionName]?{
//        return NSKeyedUnarchiver.unarchiveObject(withFile: CollectionName.ArchiveURL.path) as? [CollectionName]
//    }
    
}
