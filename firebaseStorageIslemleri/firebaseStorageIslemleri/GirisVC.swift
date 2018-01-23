//
//  GirisVC.swift
//  firebaseStorageIslemleri
//
//  Created by Esat Gözcü on 26.11.2017.
//  Copyright © 2017 Esat Gözcü. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GirisVC: UIViewController {

    
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signInButton(_ sender: Any) {
        
        if mailText.text != "" && passText.text != ""{
            
            //Kullanıcı ve şifre boş değil ise..
            //signIn() ile kullanıcıyı kayıt ediyoruz
            Auth.auth().signIn(withEmail: mailText.text!, password: passText.text!, completion: { (user, error) in
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    //Herhangi bir hata olmazsa kayıt yapıldı demektir
                    //Segue çalışacak ve diğer sayfaya geçiş yapılacak
                    self.performSegue(withIdentifier: "signSegue", sender: nil)
                }
            })
        }
        else{
            //Kullanıcı ve Şifre Boş Bırakılırsa
            //AlertDialog oluşturuyoruz
            let alert = UIAlertController(title: "Dikkat!", message: "Kullanıcı Adı ve Şifre Gerekli", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if mailText.text != "" && passText.text != ""{
            
            //Kullanıcı ve şifre boş değil ise..
            //createUser() ile kullanıcıyı kayıt ediyoruz
            Auth.auth().createUser(withEmail: mailText.text!, password: passText.text!, completion: { (user, error) in
                
                if error != nil{
                    //Sistemsel bir hata olursa AlertDialog oluşturuyoruz
                    //Örneğin şifre 6 haneden azsa Firebase otomatik hatayı bastıracaktır
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    //Herhangi bir hata olmazsa kayıt yapıldı demektir
                    //Segue çalışacak ve diğer sayfaya geçiş yapılacak
                    self.performSegue(withIdentifier: "signSegue", sender: nil)
                }
            })
        }
        else{
            //Kullanıcı ve Şifre Boş Bırakılırsa
            //AlertDialog oluşturuyoruz
            let alert = UIAlertController(title: "Dikkat!!", message: "Kullanıcı Adı ve Şifre Gerekli", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
