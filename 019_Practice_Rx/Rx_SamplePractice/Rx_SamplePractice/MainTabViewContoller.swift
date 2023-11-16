//
//  ViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/14.
//

import UIKit

final class MainTabViewContoller: UITabBarController {
    
    private let simpleTableView = SimpleTableViewController()
    private let laboratoryView = LaboratoryViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }

    private func configureTabBar() {
        simpleTableView.tabBarItem.image = UIImage(systemName: "tablecells")
        laboratoryView.tabBarItem.image = UIImage(systemName: "slider.horizontal.below.rectangle")
        
        let viewControllers = [simpleTableView, laboratoryView].map { UINavigationController(rootViewController: $0) }
        
        setViewControllers(viewControllers, animated: true)
    }
}

