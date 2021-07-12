//
//  Constants.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit
//let appId = 60b5ca5885fa4c491962e5e8
struct api{
    static let url = "https://dummyapi.io/data/api/user?limit=20&page="
    static let userProfile = "https://dummyapi.io/data/api/user/"
}

struct Colors{
    static let headertextColor = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
    static let textColor = UIColor(red: 99/255, green: 111/255, blue: 126/255, alpha: 1)
    static let sliderBackground = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 0.7)
    static let gray = rgba(163, 166, 182, 1)
    static let timeSelectionBackground = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 0.07)
    static let themeGreen = UIColor(red: 39/255, green: 164/255, blue: 60/255, alpha: 1)
    
    static func rgba(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat,_ alpha:CGFloat)->UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
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
        static let viewController = "ViewController"
        static let mainViewController = "MainViewController"
        static let agentsController = "AgentsController"
        static let slider = "SliderController"
    }
    struct xib{
        static let filter = "Filters"
        static let recent = "Recents"
        static let searchBar = "SearchBar"
    }
    struct segues{
        static let pageSegue = "pagecontroller"
    }
}
struct Storyboard{
    static let main: UIStoryboard = UIStoryboard(name: Constants.StoryBoard.main, bundle: nil)
}
enum Directions{
    case left
    case right
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
//        let horizontalConstraint = innerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//        let verticalConstraint = innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        
        
        let topConstraint = innerView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomConstraint = innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        bottomConstraint.priority = UILayoutPriority(900)
        let leadingConstraint = innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingConstraint = innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        self.addConstraints([topConstraint,bottomConstraint,leadingConstraint,trailingConstraint])
    }
}
extension UIColor{
    
}


