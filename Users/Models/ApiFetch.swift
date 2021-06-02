//
//  ApiFetch.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import Foundation
class FetchApi{
    private let appId = "60b5ca5885fa4c491962e5e8"
    func request(url:String,completion: @escaping (_ data: Data)->()){
        
        guard let url = URL(string: url) else{return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
          "Content-Type": "application/json",
            "app-id": appId
        ]
        URLSession.shared.dataTask(with: request,completionHandler: {
            (data, response, error) in
            if let data = data, error == nil{
               completion(data)
            }else{
                print("Error in api")
            }
        }).resume()
       
    }
    
    func requestUser(count:Int,completionHandler: @escaping (_ data: usersData)->()){
        request(url: api.url+"\(count)", completion: {
            (data) in
            do{
                let json = try JSONDecoder().decode(usersData.self,from:data)
                completionHandler(json)
            }catch{
                print("ERRORs")
            }
        })
    }
    
    func requestuserProfile(for id:String,completionHandler: @escaping (_ data: UserProfile)->()){
        
        request(url: api.userProfile+"\(id)", completion: {
            (data) in
            do{
                let json = try JSONDecoder().decode(UserProfile.self,from:data)
                completionHandler(json)
            }catch{
                print("ERRORs")
            }
        })
       
    }
    
    
}



/*
 func request(){
     let url = URL(string: api.url)!
     var request = URLRequest(url: url)
     request.allHTTPHeaderFields = [
       "Content-Type": "application/json",
         "app-id": api.appId
     ]

     URLSession.shared.dataTask(with: request) { (data, response, error) in
       guard error == nil else { return }
         var fetchedData : usersData?
         guard let data = data, let _ = response else { return }
       // handle data
         do{
             let json = try JSONDecoder().decode(usersData.self,from:data)
             fetchedData = json
         }catch{
             print("ERRORs")
         }
         guard let fetchedData = fetchedData else{ return }
         print(fetchedData)
     }.resume()
 }

 */


/*
 do{
     let json = try JSONDecoder().decode(usersData.self,from:data)
     completion(json)
 }catch{
     print("ERRORs")
 }
 */
