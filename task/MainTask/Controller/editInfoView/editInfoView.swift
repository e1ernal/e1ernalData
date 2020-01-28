//
//  editInfoView.swift
//  MainTask
//
//  Created by кирилл корнющенков on 09.01.2020.
//  Copyright © 2020 кирилл корнющенков. All rights reserved.
//

import UIKit
import Firebase

class editInfoView: UIViewController {
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var newSonameTextField: UITextField!
    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet var mainView: UIView!
    var ref: DatabaseReference!
    @IBOutlet weak var saveDataView: UIView!
    @IBOutlet weak var progressSaveData: UIProgressView!{
        didSet{
            progressSaveData.progress = 0
        }
    }
    
    //time var
    var login = String()
    var email = String()
    var id = String()
    
    //считывание нужных данных
    func jsonReadData(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [weak self](snapshot) in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let login = value?["login"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let id = value?["id"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let soname = value?["soname"] as? String ?? ""
            
            self?.newSonameTextField.text = soname
            self?.newNameTextField.text = name
            self?.id = id
            self?.email = email
            self?.login = login
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func saveNameAndSoname(){
        let newNameText = newNameTextField.text
        let newSomeText = newSonameTextField.text
        if newNameText != "" && newSomeText != ""{
            ref.child("users").child(loginReturn()).setValue(["name":newNameText,"soname":newSomeText,"email":email,"id":loginReturn(),"login":login])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        imageSetting(sender: peopleImage)
        jsonReadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
    }
    
    func imageSetting(sender:UIImageView){
        sender.layer.cornerRadius = sender.frame.height / 2
        sender.clipsToBounds = true
    }
    
    func loginReturn() -> String{
        let user = Auth.auth().currentUser?.uid
        return user!
    }
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        alertImage()
    }
    
    //MARK: alert Для загрузки фото
    private func alertImage(){
        let alert = UIAlertController(title: nil, message: "Выберите способ загрузки израбражения", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "camera", style: .default) { (action) in
            self.chooseImage(sourse: .camera)
        }
        let photoLibAction = UIAlertAction(title: "photo", style: .default) { (action) in
            self.chooseImage(sourse: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(photoLibAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    
    //загрузка фото на сервер
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        saveImage()
        saveNameAndSoname()
    }
    
    
    func loadImage(){
           let storageRef = Storage.storage().reference(withPath: "imagePeople/\(loginReturn()).jpg")
           storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
               if let error = error{
                   print(error.localizedDescription)
                   return
               }
               if let data = data{
                 self?.peopleImage.image = UIImage(data: data)
               }
           }
       }
    
    func saveImage(){
        mainView.alpha = 0.5
        saveDataView.isHidden = false
        let uploadRef = Storage.storage().reference(withPath: "imagePeople/\(loginReturn()).jpg")
        let imageData = (peopleImage.image?.jpegData(compressionQuality: 0.75))!
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        let taskReference = uploadRef.putData(imageData,metadata: uploadMetadata){(dowloadMetadata,error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
        taskReference.observe(.progress) { [weak self](snapshot) in
            guard let pctThere = snapshot.progress?.fractionCompleted else { return }
            self?.progressSaveData.progress = Float(pctThere)
            if self?.progressSaveData.progress == 1{
                self?.saveDataView.isHidden = true
                self?.mainView.alpha = 1
            }
        }
    }
}

//MARK: для фоточек
extension editInfoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //крч для загрузки фоточек или сделать фоточку Magic
     private func chooseImage(sourse:UIImagePickerController.SourceType){
         if UIImagePickerController.isSourceTypeAvailable(sourse){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            self.present(imagePicker,animated: true,completion: nil)
         }
     }
    //для установление фото из загруженной фото ))))
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        peopleImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        peopleImage.contentMode = .scaleAspectFill
        peopleImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
