//
//  UserCell.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet var label : UILabel!
    @IBOutlet var value : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(label:String,value:String){
        self.label.text = label
        self.value.text = value
    }
   
    
}
