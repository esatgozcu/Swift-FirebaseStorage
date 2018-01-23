//
//  FirstViewController.swift
//  firebaseStorageIslemleri
//
//  Created by Esat Gözcü on 26.11.2017.
//  Copyright © 2017 Esat Gözcü. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//Resimlerin url olarak indirip sayfamızda gözümeksini sağlayan framework'ü dahil ediyoruz
import SDWebImage

class FirstViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var resimArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        resimdata()
    }
    
    func resimdata(){
        
        //Veritabanından resimlerin linkine çekiyoruz
        Database.database().reference().child("resimler").observe(DataEventType.childAdded) { (snapchat) in
            
            let values = snapchat.value! as! NSDictionary
            for _ in values
            {
                let resim = values["image"]
                //resimArraye resimlerin linkleri tek tek ekliyoruz
                self.resimArray.append(resim as! String)
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tableView satır sayısını döndürüyoruz
        return resimArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Satırlarda ne olacağını belirliyoruz
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        //resimArray'deki resimleri cell'lere aktarıyoruz
        //Url biçimindeki resimleri sayfada göstermemize olanak sağlıyor
        cell.postImage.sd_setImage(with: URL(string: self.resimArray[indexPath.row]))
        
        return cell
    }
}

