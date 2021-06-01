//
//  CollectionCell.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet var userImage : UIImageView!
    @IBOutlet var userLabel : UILabel!
    var imageLoader = ImageController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data : userData){
        userLabel.text = data.firstName
        userLabel.textColor = Colors.textColor
        imageLoader.obtainImageWithPath(imagePath: data.picture) { (image) in
            self.userImage.image = image
        }
        userImage.rounded()
//        self.backgroundColor = .blue
        
    }
}
