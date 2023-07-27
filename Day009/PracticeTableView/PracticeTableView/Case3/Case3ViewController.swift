//
//  Case3ViewController.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import UIKit

class Case3ViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
}

extension UIViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return TodoSectionType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = TodoSectionType(rawValue: section) else { return nil }
        
        return sectionType.title
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = TodoSectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .unDone:
            return TodoManager.shared.unDoneTodo.count
        case .done:
            return TodoManager.shared.doneTodo.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = TodoSectionType(rawValue: indexPath.section),
              let unDoneTodoCell = tableView.dequeueReusableCell(withIdentifier: "unDoneTodoCell"),
              let doneTodoCell = tableView.dequeueReusableCell(withIdentifier: "doneTodoCell") else { return UITableViewCell() }
              
        switch sectionType {
        case .unDone:
            return unDoneTodoCell
        case .done:
            return doneTodoCell
        }
    }
}
