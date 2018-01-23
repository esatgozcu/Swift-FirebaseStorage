//
//  SecondViewController.swift
//  firebaseStorageIslemleri
//
//  Created by Esat Gözcü on 26.11.2017.
//  Copyright © 2017 Esat Gözcü. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class SecondViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var uuid = NSUUID().uuidString
    @IBOutlet weak var resimView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tıklanabilirliği aktif hale getiriyoruz
        resimView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.choosePhoto))
        resimView.addGestureRecognizer(recognizer)
    }

    @objc func choosePhoto()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        //Kamerayıda seçebiliriz  picker.sourceType = .camera
        //Resim galerisine gidiyoruz
        picker.sourceType = .photoLibrary
        //Fotoğrafı düzenlemeyi aktif hale getiriyoruz
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Resimi seçtikten sonra..
        resimView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postButton(_ sender: Any) {
        
        //Klasörümüzü tanımlıyoruz
        let mediaFolder = Storage.storage().reference().child("media")
        
        //Resmimizi dataya çeviriyoruz
        if let data = UIImageJPEGRepresentation(resimView.image!, 0.5)
        {
            mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    //Eğer datayı kayıt ederken hata oluşursa
                    //AlertDialog oluşturup hatayı bastırıyoruz
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true, completion: nil)
                }
                else{
                    
                    //Hata yoksa datayı kayıt ediyoruz(Storage)
                    let imageURL = metadata?.downloadURL()?.absoluteString
                    
                    //Database kayıt ediyoruz(Database)
                    let post = ["image": imageURL!] as  [String : Any]
                    Database.database().reference().child("resimler").childByAutoId().setValue(post)
                    
                    //Resim yüklendikten sonra resimView'i eski haline döndürüyoruz
                    self.resimView.image = UIImage(named: "resimyukle.jpg")
                    //Resimlerin gösterileceği yere geçiş yapıyoruz
                    self.tabBarController?.selectedIndex = 0
                }
            })
        }
    }
}

