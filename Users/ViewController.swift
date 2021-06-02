//
//  ViewController.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    var filterTable : Filters?
    var recentCollection : Recents?
    @IBOutlet var filterView : UIView!
    @IBOutlet var recentView : UIView!
    @IBOutlet var searchBar: UISearchBar!
    
    let storyBoard: UIStoryboard = UIStoryboard(name: Constants.StoryBoard.main, bundle: nil)
    var userController : UserDetailController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        createTable()
        createView()
        loadData()
        
//        testApi()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
    
        guard let table = filterTable, let collection = recentCollection else{return}
       
        let userListUrl = api.url
        FetchApi.request(url: userListUrl, completion: {
            (jsonData) in
            let userList : UsersData = jsonData.decode()
            table.dataOfUsers = userList.data
            collection.cellData = userList.data
            print("\(table.dataOfUsers.count)  ju")
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
        FetchApi.request(url: api.url, completion: {
            (data) in
            let user : UsersData = data.decode()
            print(user)
        })
    }
    
    func createTable(){
        filterTable = Bundle.main.loadNibNamed(Constants.xib.filter, owner: nil)![0] as? Filters
        guard  let filterTable = filterTable else { return }
        filterTable.frame = filterView.bounds
        filterView.addSubview(filterTable)
        filterTable.showUserData = {[weak self]
            (userData) in
            guard let self = self else{return}
            DispatchQueue.main.async {
                self.userController = self.storyBoard.instantiateViewController(identifier: Constants.StoryBoard.userViewController)
                guard let userController = self.userController else{return}
                userController.profileData = userData
                userController.title = userData.firstName
                guard let presentController = self.navigationController else { return }
                presentController.pushViewController(userController, animated: true)
            }
         
            
        }
    }
    func createView(){
        recentCollection = Bundle.main.loadNibNamed(Constants.xib.recent, owner: nil)![0] as? Recents
        guard let recentCollection  = recentCollection else{return }
        recentCollection.frame = CGRect(x: 0, y: 0, width: recentView.frame.width-10, height: recentView.frame.height)
        recentView.addSubview(recentCollection)
        print(recentView.frame.width,recentView.frame.height)
        print(recentCollection.frame.height,recentCollection.frame.width)
    }
    
    
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let filterTable = self.filterTable else{return}
        print(filterTable.filteredData.count)
        filterTable.filteredData = searchText.isEmpty ? filterTable.dataOfUsers : filterTable.dataOfUsers.filter({
            return $0.firstName.contains(searchText)
        })
        
        if searchText == "" {
            self.searchBar.endEditing(true)
            }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
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
