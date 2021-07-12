//
//  PageController.swift
//  Users
//
//  Created by Jeyaram on 17/06/21.
//

import UIKit

class PageController: UIPageViewController {
    var controllers = [UIViewController]()
    var parentController : MainViewController?
    var searchDelegate : CustomSearchBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        getViewControllers()
        dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        setParent()
    }
}
extension PageController : UIPageViewControllerDataSource{
    func getViewControllers(){
        let viewController = Storyboard.main.instantiateViewController(identifier: Constants.StoryBoard.viewController) as ChildController
        let userController = Storyboard.main.instantiateViewController(identifier: Constants.StoryBoard.userViewController)
        let agentsController = Storyboard.main.instantiateViewController(identifier: Constants.StoryBoard.agentsController)
        let navigation = UINavigationController(rootViewController: viewController)
        let sliderController = Storyboard.main.instantiateViewController(identifier: Constants.StoryBoard.slider)
        controllers = [sliderController]
        
       self.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getViewController(viewController: viewController, direction: .left)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        getViewController(viewController: viewController, direction: .right)
    }
    func getViewController(viewController currentController:UIViewController,direction: Directions)->UIViewController?{
        guard let index = controllers.firstIndex(of: currentController)else{return nil}
        var newIndex = 0
        switch(direction){
        case .left:
            newIndex = index-1
        case .right:
            newIndex = index+1
        }
        guard newIndex >= 0 else{return nil}
        guard controllers.count > newIndex else{return nil}
        
        return controllers[newIndex]
    }
    
    
}
extension PageController{
    
    func setParent(){
//        parentController?.searchBar?.customSearchBardelegate = self
    }
    
    
    
   
}
