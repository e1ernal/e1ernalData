//
//  FindWorker.swift
//  MainTask
//
//  Created by кирилл корнющенков on 04.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class FindWorker: UIViewController {
    
    var backgroundImage : UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var countPeople:[jsonAllLogin] = []
    var allLoginAndEmailArray:[jsonAllLogin] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference() //.reference(withPath: "users")
        if countPeople.count == 0 {
            assignbackground()
            loadPeople()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jsonLoginAndEmail()
    }
    
    //как-то пытаемся загрузить челиков
    func loadPeople(){
        let loadRef = ref.child("worker").child(Auth.auth().currentUser!.uid)
        loadRef.observe(.value) { [weak self](snapshot) in
            var _arr:[jsonAllLogin] = []
            for user in snapshot.children{
                let data = jsonAllLogin(snapshot: user as! DataSnapshot)
                _arr.append(data)
            }
            self?.countPeople = _arr
        }
    }
    
    func jsonLoginAndEmail(){
        ref.child("users").observe(.value) { [weak self](snapshot) in
            var _arr:[jsonAllLogin] = []
            for item in snapshot.children{
                let data = jsonAllLogin(snapshot: item as! DataSnapshot)
                _arr.append(data)
            }
            self?.allLoginAndEmailArray = _arr
            self?.collectionView.reloadData()
        }
    }
    
    //добавление рабочик на сервер
    func addWorker(value:jsonAllLogin){
        let workerRef = ref.child("worker").child(Auth.auth().currentUser!.uid).child(value.id)
        workerRef.setValue(["login":value.login,"email":value.email,"id":value.id])
    }
    
    //MARK: добавление нового сотрудника
    private func alertAddPeople(){
        let alert = UIAlertController(title: "Введите email или login пользователя", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        //добавить проверку на наличие такого пользователя и добавить на сервер и везде крч
        let actionAdd = UIAlertAction(title: "Add", style: .default) { [weak alert,weak self] (addAlert) in
            let text = alert?.textFields?.first?.text!
            for i in self!.allLoginAndEmailArray{
                if i.email == text || i.login == text{
                    self?.countPeople.append(i)
                    self?.collectionView.reloadData()
                    self?.addWorker(value:i)
                }
            }
        }
        alert.textFields?.first?.placeholder = "Email/login"
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert,animated: true,completion: nil)
    }
    
    @IBAction func addPeopleButton(_ sender: Any) {
        alertAddPeople()
    }
    
    func assignbackground(){
           backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "noWorkers")
           backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
           self.collectionView.insertSubview(backgroundImage, at: 0)
    }
    
    //передача данных
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workerInfo"{
            if let aboutPeopleController = segue.destination as? aboutPeople {
                let index:Int = sender! as! Int
                aboutPeopleController.id = countPeople[index].id
            }
        }
    }
}

extension FindWorker: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if countPeople.count > 0 {
            backgroundImage.image = nil
        }
        return countPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FindWorkerCell
        cell.nameLabel.text = countPeople[indexPath.row].login
        //load image
        let storageRef = Storage.storage().reference(withPath: "imagePeople/\(countPeople[indexPath.row].id).jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024) {(data, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                cell.imageCell.image = UIImage(data: data)
            }
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = (collectionView.frame.width - 42) / 3
        return CGSize(width: size, height: size + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        performSegue(withIdentifier: "workerInfo", sender: index)
    }
    }

