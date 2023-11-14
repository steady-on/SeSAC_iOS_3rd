//
//  ViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/14.
//

import UIKit

final class MainTabViewContoller: UITabBarController {
    
    private let simpleTableView = SimpleTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }

    private func configureTabBar() {
        simpleTableView.tabBarItem.image = UIImage(systemName: "tablecells")
        
        let viewControllers = [simpleTableView].map { UINavigationController(rootViewController: $0) }
        
        setViewControllers(viewControllers, animated: true)
    }
}

