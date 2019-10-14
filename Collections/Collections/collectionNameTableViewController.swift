//
//  CollectionNameTableViewController.swift
//  Collections
//
//  Created by Samantha Maxey on 10/10/19.
//  Copyright © 2019 Boise State. All rights reserved.
//

import UIKit

class CollectionNameTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var names = [CollectionName]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleCollection()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CollectionNameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CollectionNameTableViewCell else{
            fatalError("The dequeued cell is not an instance of CollectionNameTableViewCell.")
        }
        
        let name = names[indexPath.row]
        cell.collectionNameLabel.text = name.name

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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func loadSampleCollection(){
        let collection1 = CollectionName(name: "Books")!
        names += [collection1]
    }
}
