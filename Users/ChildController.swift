//
//  ViewController.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import UIKit

class ChildController: UIViewController {
    
    var filterTable : Filters?
    var recentCollection : Recents?
    @IBOutlet var filterView : UIView!
    @IBOutlet var recentView : UIView!
    @IBOutlet var controllerView : UIView!
    var searchBar: UISearchBar?
    var maxorigin  : CGFloat = 0
    let storyBoard: UIStoryboard = UIStoryboard(name: Constants.StoryBoard.main, bundle: nil)
    var userController : UserDetailController?
    var lastOffset : CGFloat = 0
    lazy var faButton = UIButton()
    @IBOutlet var topConstraints : NSLayoutConstraint!
    
    var viewController : MainViewController?
    var searchBarDelegate : CustomSearchBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchBar.delegate = self
//        addGestureforSearch()
       
        createTable()
//        updateConstraints()
        createView()
        loadData()
        searchBarDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addSubview(faButton)
    
//        testApi()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Child appearing")
        setDelegate()
        
       setupButton()
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Child Disappearing")
    }
    func setupButton() {
        faButton.frame = .zero
        NSLayoutConstraint.activate([
            faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            faButton.heightAnchor.constraint(equalToConstant: 40),
            faButton.widthAnchor.constraint(equalToConstant: 40)
            ])
        faButton.layer.cornerRadius = 20
        faButton.layer.masksToBounds = true
        faButton.layer.borderColor = UIColor.lightGray.cgColor
        faButton.layer.borderWidth = 2
        faButton.translatesAutoresizingMaskIntoConstraints = false
        faButton.backgroundColor = .systemYellow
        faButton.setImage(UIImage(systemName: "chevron.up.circle"), for: .normal)
        faButton.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
        
    }
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {return}
        guard let filter = filterTable else{return}
        filter.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//        heightAnchor = filter.heightAnchor.constraint(equalToConstant: filter.frame.height-keyboardSize.height)
//        bottomConstraint!.isActive  = false
//        heightAnchor!.isActive = true
        
       
    }
    @objc func keyboardWillHide(notification: NSNotification){
        guard let filterTable = filterTable else{return}
        filterTable.contentInset = UIEdgeInsets(top: 0, left: 0,bottom: 0, right: 0)
        
//        heightAnchor!.isActive = false
//        bottomConstraint!.isActive = true
    }
    @objc func fabTapped(_ button:UIButton){
        if let filterTable = filterTable{
            filterTable.setContentOffset(.zero, animated: true)
        }
        
    }
    func loadData(){
    
        guard let table = filterTable, let collection = recentCollection else{return}
       
        let userListUrl = api.url
        FetchApi.request(url: userListUrl, completion: {
            (jsonData) in
            let userList : UsersData = jsonData.decode()
            table.dataOfUsers = userList.data
            collection.cellData = userList.data
//            print("\(table.dataOfUsers.count)  ju")
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
        maxorigin =  self.recentView.frame.height * -1
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
        filterTable.tableScroll = {[weak self]
            (distance) in
            guard let self = self else{return}
//            print(filterTable.contentOffset.y)
            if(distance<0 && filterTable.contentOffset.y <= 0){
//                print("first  if",filterTable.contentOffset)
                if(self.topConstraints.constant - distance <= 0){
//                    print("first if first if")
                    self.topConstraints.constant -= distance
                }
            }else{
//                print("first else",filterTable.contentOffset,distance)
                if(distance<0 && filterTable.contentOffset == .zero){
//                    print("first else first if")
                    if(self.topConstraints.constant - distance <= 0){
//                        print("first else first if first if")
                        self.topConstraints.constant -= distance
                    }else{
//                        print("first else first if first else")
                        self.topConstraints.constant = 0
                    }

                }
                else if distance>0 && filterTable.contentOffset.y >= 0{
                    if((self.recentView.frame.origin.y * -1) < self.recentView.frame.height){
//                        print("first else second if")
                        if(self.recentView.frame.origin.y - distance)<=0{
//                            print("first else second if first if")
                            if(self.recentView.frame.origin.y - distance >= self.maxorigin){
//                                print("first else second if first if first if ")
                                self.topConstraints.constant -= distance
                                filterTable.contentOffset = .zero
                            }else{
//                                print("first else second if first if first else ")
                                self.topConstraints.constant = self.maxorigin
                            }
                        }
                    }
                }

            }
 
        }
    }
    func createView(){
        recentCollection = Bundle.main.loadNibNamed(Constants.xib.recent, owner: nil)![0] as? Recents
        guard let recentCollection  = recentCollection else{return }
        recentCollection.frame = recentView.bounds
        recentView.addSubview(recentCollection)
        
//        print(recentView.frame.width,recentView.frame.height)
//        print(recentCollection.frame.height,recentCollection.frame.width)
    }
    func setDelegate(){
        var pageController = self.parent as? PageController
        if(pageController == nil){pageController = self.parent?.parent as? PageController}
        guard let pageController = pageController else{return}
        let mainController = pageController.parentController
        mainController?.searchBarDelegate = self
    }
   
    
}
extension ChildController : CustomSearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let filterTable = self.filterTable else{return}
        print(filterTable.filteredData.count)
        filterTable.filteredData = searchText.isEmpty ? filterTable.dataOfUsers : filterTable.dataOfUsers.filter({
            return $0.firstName.contains(searchText)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("Search")
        if let searchBarText = searchBar.text, searchBarText.isEmpty{            animateView(isHide: false)
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
/*
extension ChildController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let filterTable = self.filterTable else{return}
        print(filterTable.filteredData.count)
        filterTable.filteredData = searchText.isEmpty ? filterTable.dataOfUsers : filterTable.dataOfUsers.filter({
            return $0.firstName.contains(searchText)
        })
   
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchBar = self.searchBar else{return}
        searchBar.endEditing(true)
        if let searchBarText = searchBar.text, searchBarText.isEmpty{
            animateView(isHide: false)
        }
        
            
    }
   
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Starting..")
        animateView(isHide: true)
        
    }
    func addGestureforSearch(){
        guard let searchBar = self.searchBar else{return}
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {

             clearButton.addTarget(self, action: #selector(self.cancelbuttonClicked), for: .touchUpInside)
        }
        
    }
    @objc func cancelbuttonClicked(){
        guard let searchBar = self.searchBar else{return}
        searchBar.endEditing(true)
        animateView(isHide: false)
    }
    func animateView(isHide:Bool){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.recentView.isHidden = isHide
        }, completion: nil)
    }
    
}*/

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
