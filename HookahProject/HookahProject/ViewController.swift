//
//  ViewController.swift
//  HookahProject
//
//  Created by DMITRY on 14/12/2019.
//  Copyright © 2019 Dmitry Smirnykh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    var workers = [Worker]()
    var Data = [Work]()
    
    @IBOutlet weak var find: UISearchBar!
    
    @IBAction func sort(_ sender: UIButton) {
        for i in 0..<(Data.count - 1) {
            for j in 0..<(Data.count - i - 1) {
                if Data[j].year > Data[j + 1].year {
                    var temp = Data[j]
                    Data[j] = Data[j + 1]
                    Data[j + 1] = temp
                    temp = Work()
                }
            }
        }
        tableView.reloadData()
        let alert = UIAlertController(title: "Sorted.", message: "Save?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            for i in 0..<self.Data.count {
                self.edit(index: i, name: self.Data[i].name!, position: self.Data[i].position!, year: Int(self.Data[i].year))
            }
        }
        let actionNo = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "WORKER",
                                          message: "Add a new worker",
                 preferredStyle: .alert)

            let saveAction = UIAlertAction(title: "Save",
                                            style: .default) { (action: UIAlertAction!) -> Void in
            
                let name = alert.textFields![0]
                let position = alert.textFields![1]
                let year = alert.textFields![2]
                self.update(name: name.text!, position: position.text!, year: Int(year.text!)!)
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
        tableView.delegate = self
        tableView.dataSource = self
        request()
        tableView.tableFooterView = UIView()
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.name.text = Data[indexPath.row].name
        cell.position.text = Data[indexPath.row].position
        cell.year.text = String(Data[indexPath.row].year)
        cell.photo.image = UIImage(named: "user.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeElement(index: indexPath.row)
            request()
            tableView.reloadData()
        }
    }
}
import CoreData
extension ViewController{
    //
    func request() {
        let fetchRequest:NSFetchRequest = Work.fetchRequest()
        do { Data = try context.fetch(fetchRequest) }
        catch{}
    }
    func update(name: String, position: String, year: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "Work", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Work
        taskObject.name = name
        taskObject.position = position
        taskObject.year = Int16(year)
        do{ try context.save() }catch{}
        request()
        self.tableView.reloadData()
    }
    func removeElement(index: Int) {
        let name = Data[index]
        context.delete(name)
        do{ try context.save() }
        catch{}
    }
    func edit(index: Int, name: String, position: String, year: Int) {
        let element = Data[index]
        element.name = name
        element.position = position
        element.year = Int16(year)
        do{ try context.save() }catch{}
    }
}
