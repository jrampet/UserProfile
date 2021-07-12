//
//  AgentsController.swift
//  Users
//
//  Created by Jeyaram on 17/06/21.
//

import UIKit

class AgentsController: UIViewController {
    var recentCollection : Recents?
    var filterTable : Filters?
    @IBOutlet var topConstraints : NSLayoutConstraint!
    @IBOutlet var recentView : UIView!
    @IBOutlet var filterView : UIView!
    var maxorigin  : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoardAction()
        createView()
        createTable()
        loadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Agents appearing")
        createSearchBar()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Agents disappearing")
    }
    
    func keyBoardAction(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func loadData(){
        guard let table = filterTable, let collection = recentCollection else{return}
        let userListUrl = api.url+"2"
        FetchApi.request(url: userListUrl, completion: {
            (jsonData) in
            let userList : UsersData = jsonData.decode()
            table.dataOfUsers = userList.data
            collection.cellData = userList.data
        })
    }
    
    func createView(){
        recentCollection = Bundle.main.loadNibNamed(Constants.xib.recent, owner: nil)![0] as? Recents
        guard let recentCollection  = recentCollection else{return }
        recentCollection.frame = recentView.bounds
        recentView.addSubview(recentCollection)
    }
    func createTable(){
        filterTable = Bundle.main.loadNibNamed(Constants.xib.filter, owner: nil)![0] as? Filters
        guard  let filterTable = filterTable else { return }
        maxorigin =  self.recentView.frame.height * -1
        filterView.addInnerView(innerView: filterTable)
        filterTable.showUserData = {[weak self]
            (userData) in
            guard let self = self else{return}
            DispatchQueue.main.async {
               let userController = Storyboard.main.instantiateViewController(identifier: Constants.StoryBoard.userViewController) as UserDetailController
                userController.profileData = userData
                userController.title = userData.firstName
                guard let presentController = self.navigationController else { return }
                presentController.pushViewController(userController, animated: true)
            }
        }
        filterTable.tableScroll = {
            [weak self]
            (distance) in
            guard let self = self else{return}
            if(distance<0 && filterTable.contentOffset.y <= 0){
                if(self.topConstraints.constant - distance <= 0){
                    self.topConstraints.constant -= distance
                }
            }else{
                if(distance<0 && filterTable.contentOffset == .zero){
                    if(self.topConstraints.constant - distance <= 0){
                        self.topConstraints.constant -= distance
                    }else{
                        self.topConstraints.constant = 0
                    }

                }
                else if distance>0 && filterTable.contentOffset.y >= 0{
                    if((self.recentView.frame.origin.y * -1) < self.recentView.frame.height){
                        if(self.recentView.frame.origin.y - distance)<=0{
                            if(self.recentView.frame.origin.y - distance >= self.maxorigin){
                                self.topConstraints.constant -= distance
                                filterTable.contentOffset = .zero
                            }else{
                                self.topConstraints.constant = self.maxorigin
                            }
                        }
                    }
                }

            }
 
        }
    }
    func createSearchBar(){
        let pageController = self.parent as! PageController
        let mainController = pageController.parentController
//        print(mainController,"Agents")
        mainController?.searchBar?.customSearchBardelegate = self
        
    }
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {return}
        guard let filter = filterTable else{return}
        filter.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
    @objc func keyboardWillHide(notification: NSNotification){
        guard let filterTable = filterTable else{return}
        filterTable.contentInset = UIEdgeInsets(top: 0, left: 0,bottom: 0, right: 0)

    }
}

extension AgentsController : CustomSearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let filterTable = self.filterTable else{return}
        print(filterTable.filteredData.count,"Agents")
        filterTable.filteredData = searchText.isEmpty ? filterTable.dataOfUsers : filterTable.dataOfUsers.filter({
            return $0.firstName.contains(searchText)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let searchBarText = searchBar.text, searchBarText.isEmpty{
            animateView(isHide: false)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animateView(isHide: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        animateView(isHide: false)
    }
    func animateView(isHide:Bool){
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.recentView.isHidden = isHide
        }, completion: nil)
    }
    
    
}
