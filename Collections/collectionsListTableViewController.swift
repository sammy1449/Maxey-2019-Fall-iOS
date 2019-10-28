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


    //Mark: Actions
    @IBAction func unwindToCollectionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? CollectionViewController, let collection = sourceViewController.collection{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an exsting collection
                collections[selectedIndexPath.row] = collection
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{

                let newIndexPath = IndexPath(row: collections.count, section: 0)

                collections.append(collection)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            //Save the collections
            saveCollections()
        }

    }

    //Mark: Private Methods
    //Checking the running of the app
//    private func loadSampleBooks(){
//        let photo1 = UIImage(named: "percy1")
//        let photo2 = UIImage(named: "harrypotter1")
//
//        guard let book1 = Collection(title: "Percy Jackson and the Lightning Thief", author: "Rick Riordian", year: 2005, photo: photo1) else{
//            fatalError("Unable to instantiate book1")
//        }
//
//        guard let book2 = Collection(title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", year: 1997, photo: photo2) else{
//            fatalError("Unable to instantiate book2")
//        }
//
//        collections += [book1, book2]
//    }
    
    private func saveCollections(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(collections, toFile: Collection.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Collections successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save collections...", log: OSLog.default, type: .error)
        }
    }

    private func loadCollections() -> [Collection]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Collection.ArchiveURL.path) as? [Collection]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedCollections = loadCollections(){
            collections += savedCollections
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return collections.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "collectionsListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? collectionsListTableViewCell else{
            fatalError("The dequeued cell is not an instance of collectionsListTableViewCell.")
        }

        let collection = collections[indexPath.row]

        cell.nameLabel.text = collection.title
        cell.yearLabel.text = "\(collection.year)"

        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            collections.remove(at: indexPath.row)
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

        case "AddItem":
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

            let selectedCollection = collections[indexPath.row]

            collectionDetailViewController.collection = selectedCollection

        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }


}
