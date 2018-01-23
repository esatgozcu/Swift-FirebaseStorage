//
//  feedCell.swift
//  firebaseStorageIslemleri
//
//  Created by Esat Gözcü on 26.11.2017.
//  Copyright © 2017 Esat Gözcü. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
