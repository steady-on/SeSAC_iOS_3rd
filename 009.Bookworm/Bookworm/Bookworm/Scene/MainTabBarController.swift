//
//  MainTabBarController.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/04.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //    let myShelfViewController = MainViewController()
    //    let browseViewController = BrowseViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let myShelfViewController = storyboard.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController,
        let browseViewController = storyboard.instantiateViewController(withIdentifier: BrowseViewController.identifier) as? BrowseViewController
        else {
            return
        }

        myShelfViewController.tabBarItem.title = "내 책장"
        myShelfViewController.tabBarItem.image = UIImage(systemName: "books.vertical.fill")
        
        browseViewController.tabBarItem.title = "둘러보기"
        browseViewController.tabBarItem.image = UIImage(systemName: "globe")
        
        let myShelfView = UINavigationController(rootViewController: myShelfViewController)
        let browseView = UINavigationController(rootViewController: browseViewController)
        
        let items = [myShelfView, browseView]
        
        setViewControllers(items, animated: true)
    }
}
