//
//  ViewController.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class ViewController: UIViewController {
    let apifetch = FetchApi()
    var filterTable : Filters?
    var recentCollection : Recents?
    @IBOutlet var filterView : UIView!
    @IBOutlet var recentView : UIView!
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var userController : UserDetailController?
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        createView()
        loadData()
//        testApi()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        guard let table = filterTable, let collection = recentCollection else{return}
        let userListUrl = api.url
        apifetch.request(url: userListUrl, completion: {
            (jsonData) in
            let userList : usersData = Bundle.main.decode(jsonData)
            table.dataArray = userList.data
            collection.cellData = userList.data
            DispatchQueue.main.async {
                table.reloadData()
                collection.reloadData()
            }
        })
        /*apifetch.requestUser(count: 10, completionHandler: {
            (data) in
            table.dataArray = data.data
            collection.cellData = data.data
            print(table.dataArray.count)
            DispatchQueue.main.async {
                table.reloadData()
                collection.reloadData()
            }
        })*/
    }
    
    func testApi(){
        apifetch.request(url: api.url, completion: {
            (data) in
            let user : usersData = Bundle.main.decode(data)
            print(user)
        })
    }
    
    func createTable(){
        filterTable = Bundle.main.loadNibNamed("Filters", owner: nil)![0] as? Filters
        filterTable?.frame = filterView.bounds
        
        guard  let filterTable = filterTable else { return }
                filterView.addSubview(filterTable)
        
        filterTable.showUserData = {
            (userData) in
            
            
            DispatchQueue.main.async {
                self.userController = self.storyBoard.instantiateViewController(identifier: "UserDetailController")
                guard let userController = self.userController else{return}
                userController.profileData = userData
                userController.title = userData.firstName
                guard let presentController = self.navigationController else { return }
                presentController.pushViewController(userController, animated: true)
            }
         
            
        }
    }
    func createView(){
        recentCollection = Bundle.main.loadNibNamed("Recents", owner: nil)![0] as? Recents
        guard let recentCollection  = recentCollection else{return }
        recentCollection.frame = recentView.bounds
        recentView.addSubview(recentCollection)
    }
    
    
}

/*
 apifetch.request(url: api.url, completion: {
     data in
     print(data.data.count)
     table.dataArray = data.data
     collection.cellData = data.data
     print(table.dataArray.count)
     DispatchQueue.main.async {
         table.reloadData()
         collection.reloadData()
     }
 })
 */
