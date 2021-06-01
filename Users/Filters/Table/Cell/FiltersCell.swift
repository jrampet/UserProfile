//
//  FiltersCell.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class FiltersCell: UITableViewCell {

    @IBOutlet var userImage : UIImageView!
    @IBOutlet var userName : UILabel!
    @IBOutlet var userMail : UILabel!
    let imageLoader = ImageController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data:userData){
        userName.text = data.firstName + " " + data.lastName
        userMail.text = data.email
        userMail.textColor = Colors.textColor
        imageLoader.obtainImageWithPath(imagePath: data.picture) { (image) in
            self.userImage.image = image
        }
        userImage.rounded()
      
    }
    
}
