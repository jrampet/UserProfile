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
        addGestureforSearch()
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
        
        filterView.addInnerView(innerView: filterTable)
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
        recentCollection.frame = recentView.bounds
        recentView.addSubview(recentCollection)
        
        print(recentView.frame.width,recentView.frame.height)
        print(recentCollection.frame.height,recentCollection.frame.width)
    }
    func addGestureforSearch(){
        if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {

             clearButton.addTarget(self, action: #selector(self.cancelbuttonClicked), for: .touchUpInside)
        }
        
    }
    @objc func cancelbuttonClicked(){
        self.searchBar.endEditing(true)
        animateView(isHide: false)
    }
    
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let filterTable = self.filterTable else{return}
        print(filterTable.filteredData.count)
        filterTable.filteredData = searchText.isEmpty ? filterTable.dataOfUsers : filterTable.dataOfUsers.filter({
            return $0.firstName.contains(searchText)
        })
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        if let searchBarText = searchBar.text, searchBarText.isEmpty{
            animateView(isHide: false)
        }
            
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Starting..")
        animateView(isHide: true)
        
    }
    func animateView(isHide:Bool){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.recentView.isHidden = isHide
        }, completion: nil)
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
