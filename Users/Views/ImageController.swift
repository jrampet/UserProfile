//
//  ImageController.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit
class ImageController{
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    init() {
        session = URLSession.shared
        self.cache = NSCache()
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage()
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            
           let task = session.downloadTask(with: url, completionHandler: { (urlLocation, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task.resume()
        }
    }
}

extension UIImageView{
    func rounded(){
        
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
       
    }
}
