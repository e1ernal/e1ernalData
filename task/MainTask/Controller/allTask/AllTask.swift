//
//  AllTask.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class AllTask: UIViewController {
    
    var backgroundImage : UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var tableData = [allTaskStruct]()
    //search
    var filteredTableData = [allTaskStruct]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewDidLoad()
        ref = Database.database().reference()
        tableSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser?.uid != nil{
            if tableData.count == 0 {
                assignbackground()
                loadTask()
            }
        }
    }
    
    func loadTask(){
        let user:String = Auth.auth().currentUser!.uid
        ref.child("task").child(user).observe(.value) { [weak self](snapshot) in
            var _arr:[allTaskStruct] = []
            for i in snapshot.children{
                let data = allTaskStruct(snapshot: i as! DataSnapshot)
                _arr.append(data)
            }
            self?.tableData = _arr
            self?.tableView.reloadData()
        }
    }
    
    //настройки таблицы
    private func tableSetting(){
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    //добавление searchbar 
    private func searchViewDidLoad(){
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTask"{
            if let showTask = segue.destination as? showTask{
                showTask.topic = sender! as! String
            }
        }
    }
}

//MARK: tableview
extension AllTask: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData.count > 0 {
            backgroundImage.image = nil
        }
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllTaskCell
        
        if (resultSearchController.isActive) {
            cell.dateLabel.text =  "01.01.2002" //filteredTableData[indexPath.row].data
            cell.titleLabel.text = filteredTableData[indexPath.row].topic
            return cell
        }
        else {
            cell.dateLabel.text =  "01.01.2002" //tableData[indexPath.row].data
            cell.titleLabel.text = tableData[indexPath.row].topic
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let id = tableData[index].topic
        performSegue(withIdentifier: "showTask", sender: id)
    }
    //добавить фоновую картинку
    func assignbackground(){
        backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "noTasks")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.tableView.insertSubview(backgroundImage, at: 0)
    }
}

//MARK: UISearchResultsUpdating
extension AllTask: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll()
        
        let searchText = searchController.searchBar.text!
        let array = tableData.filter { $0.topic.range(of: searchText, options: [.caseInsensitive]) != nil } //|| $0.data.range(of: searchText, options: [.caseInsensitive]) != nil }
        filteredTableData = array
        
        self.tableView.reloadData()
    }
}
