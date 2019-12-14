//
//  collectionsListTableViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 10/3/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit
import os.log

class collectionsListTableViewController: UITableViewController {

    var collections = [Collection]()
    var collectionSorted : [Collection] = []
   // var collectionSection: [String] = []
   // var collectionDictionary: [[Collection]] = [[]]

    //Mark: Actions
    @IBAction func unwindToCollectionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? CollectionViewController, let collection = sourceViewController.collection{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing collection
                collectionSorted[selectedIndexPath.row] = collection
           // collectionDictionary[selectedIndexPath.section][selectedIndexPath.row] = collection
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let newIndexPath = IndexPath(row: collectionSorted.count, section: 0)
                collectionSorted.append(collection)
               // initCollection()
                //collectionDictionary.insert(collectionSorted, at: collectionDictionary.count)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                //initCollection()
            }
            //Save the collections
            saveCollections()
        }

    }

    //Mark: Private Methods
    
    
    private func saveCollections(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(collectionSorted, toFile: Collection.ArchiveURL.path)
         collectionSorted = collectionSorted.sorted(by: { $1.title > $0.title })
        tableView.reloadData()
        if isSuccessfulSave{
            os_log("Collections successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save collections...", log: OSLog.default, type: .error)
        }
    }

    private func loadCollections() -> [Collection]?{
        //collectionSorted = collections.sorted(by: { $1.title > $0.title })
        return NSKeyedUnarchiver.unarchiveObject(withFile: Collection.ArchiveURL.path) as? [Collection]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Use the edit button item provided by the table view controller
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        } else {
            // Fallback on earlier versions
        }
        navigationItem.leftBarButtonItem = editButtonItem
         
        if let savedCollections = loadCollections(){
           collectionSorted += savedCollections
        }
        collectionSorted = collectionSorted.sorted(by: { $1.title > $0.title })
        
       //initCollection()
        
    }
    
//    private func initCollection(){
//        let firstLetters = collectionSorted.map{$0.titleFirstLetter}
//        let uniqueFirstLetters = Array(Set(firstLetters))
//        collectionSection = uniqueFirstLetters.sorted()
//            collectionDictionary = collectionSection.map{
//                firstLetter in
//                    return collectionSorted
//                        .filter { $0.titleFirstLetter == firstLetter }
//                        .sorted {$0.title < $1.title}
//
//        }
//    }

    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if(collectionDictionary.count == 0){
//            return 1
//        }else{
//            return collectionDictionary.count
//        }
//    }
//
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionSorted.count
        // return collectionDictionary[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "collectionsListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? collectionsListTableViewCell else{
            fatalError("The dequeued cell is not an instance of collectionsListTableViewCell.")
        }
       
       // let collection = collectionDictionary[indexPath.section][indexPath.row]

        let collection = collectionSorted[indexPath.row]
        cell.nameLabel.text = collection.title
        cell.yearLabel.text = "\(collection.year)"
        cell.pictureImage.image = collection.photo
            
        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return collectionSection[section]
//    }
//
//     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return collectionSection
//    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            collectionSorted.remove(at: indexPath.row)
            saveCollections()
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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch(segue.identifier ?? ""){

        case "AddName":
            os_log("Adding a new collection.", log: OSLog.default, type: .debug)

        case "ShowDetail":
            guard let collectionDetailViewController = segue.destination as? CollectionViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedCollectionCell = sender as? collectionsListTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }

            guard let indexPath = tableView.indexPath(for: selectedCollectionCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }

            //let selectedCollection = collectionDictionary[indexPath.section][indexPath.row]
            let selectedCollection = collectionSorted[indexPath.row]

            collectionDetailViewController.collection = selectedCollection

        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }


}
