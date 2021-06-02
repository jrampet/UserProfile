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
    
    func configure(data : UserData){
        userLabel.text = data.firstName
        userLabel.textColor = Colors.textColor
        imageLoader.obtainImageWithPath(imagePath: data.picture) {[weak self] (image) in
            guard let self = self else{return}
            self.userImage.image = image
        }
        userImage.rounded()
//        self.backgroundColor = .blue
        
    }
}
