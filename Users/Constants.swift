//
//  Constants.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit
//let appId = 60b5ca5885fa4c491962e5e8
struct api{
    static let url = "https://dummyapi.io/data/api/user?limit="
    static let userProfile = "https://dummyapi.io/data/api/user/"
}

struct Colors{
    static let headertextColor = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
    static let textColor = UIColor(red: 99/255, green: 111/255, blue: 126/255, alpha: 1)
}
extension UIViewController{
    func pushController(_ controller: UserDetailController,with title:String){
        controller.title = title
        guard let newController = self.navigationController else { return }
        newController.pushViewController(controller, animated: true)
    }
}
struct Constants{
    struct StoryBoard{
        static let main = "Main"
        static let userViewController = "UserDetailController"
    }
    struct xib{
        static let filter = "Filters"
        static let recent = "Recents"
    }
}
extension UIImageView{
    func setImage(urlString:String){
        guard let iconurl = URL(string: urlString) else {return}
        let data = try? Data(contentsOf: iconurl)
        if let imageData = data {
            let image = UIImage(data: imageData)
           self.image = image
        }
    }
}
extension UIView{
    func addInnerView(innerView:UIView){
        self.addSubview(innerView)
        
        innerView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = innerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let verticalConstraint = innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        
        
        let topConstraint = innerView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let leadingConstraint = innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraint = innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        self.addConstraints([horizontalConstraint, verticalConstraint,  topConstraint,bottomConstraint,leadingConstraint,trailingConstraint])
    }
}
