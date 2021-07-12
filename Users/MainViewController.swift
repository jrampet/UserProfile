//
//  MainViewController.swift
//  Users
//
//  Created by Jeyaram on 17/06/21.
//

import UIKit

class MainViewController: UIViewController {

    let storyBoard: UIStoryboard = UIStoryboard(name: Constants.StoryBoard.main, bundle: nil)
    var viewController : ChildController?
    var searchBar : CustomSearchBar?
    var searchBarDelegate : CustomSearchBarDelegate?{
        didSet{
            searchBar?.customSearchBardelegate = searchBarDelegate
        }
    }
    var searchBarCreated:(()->())?
    @IBOutlet var controllerView : UIView!
    @IBOutlet var searchView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        // Do any additional setup after loading the view.
    
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.segues.pageSegue){
            let pageController = segue.destination as! PageController
            pageController.parentController = self
        }
    }

}

extension MainViewController{
    
    func createSearchBar(){
        searchBar = Bundle.main.loadNibNamed(Constants.xib.searchBar, owner: nil, options: nil)![0] as? CustomSearchBar
        guard let searchBar = searchBar else{return}
        searchBar.frame = searchView.bounds
        searchView.addSubview(searchBar)
        searchBar.customSearchBardelegate = self.searchBarDelegate
        searchBarCreated?()
    }
}


