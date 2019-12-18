//
//  TableViewController.swift
//  CourceworkWorkersiOS
//
//  Created by DMITRY on 12/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var workers = [Worker]()
    @IBAction func addElement(_ sender: Any) {
        let alert = UIAlertController(title: "WORKER",
                                      message: "Add a new worker",
             preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save",
                                        style: .default) { (action: UIAlertAction!) -> Void in
        
            let name = alert.textFields![0]
            let position = alert.textFields![1]
            let year = alert.textFields![2]
            let workerTemp = Worker()
            workerTemp.name = name.text
            workerTemp.position = position.text
            let year_ = year.text != nil ? year.text! : "0"
            workerTemp.yearOfEmployment = Int(year_)
            self.workers.append(workerTemp)
            self.tableView.reloadData()
        }
        
         let cancelAction = UIAlertAction(title: "Cancel",
                                          style: .default) { (action: UIAlertAction!) -> Void in
         }
        
        alert.addTextField {
            (name: UITextField!) -> Void in
            name.placeholder = "Name"
        }
        alert.addTextField {
            (position: UITextField!) -> Void in
            position.placeholder = "Position"
        }
        alert.addTextField {
           (year: UITextField!) -> Void in
            year.placeholder = "Year"
        }
         alert.addAction(saveAction)
         alert.addAction(cancelAction)
        
        present(alert,
             animated: true,
             completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.nameCell.text = workers[indexPath.row].name != nil ? workers[indexPath.row].name : "-"
        cell.positionCell.text = workers[indexPath.row].position != nil ? workers[indexPath.row].position : "-"
        cell.yearCell.text = workers[indexPath.row].yearOfEmployment != nil ? String(workers[indexPath.row].yearOfEmployment!) : "0"
        
        cell.photoCell.image = UIImage(named: "user.png")
        
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

}
