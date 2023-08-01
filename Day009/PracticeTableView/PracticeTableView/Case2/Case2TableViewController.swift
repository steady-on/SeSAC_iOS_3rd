//
//  Case2TableViewController.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import UIKit

class Case2TableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Case2SectionType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = Case2SectionType(rawValue: section) else { return nil }
        return sectionType.title
    }
    
    override func tableView(_ tableView: UITableView,    numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = Case2SectionType(rawValue: section) else { return 0 }
        
        return sectionType.menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = Case2SectionType(rawValue: indexPath.section),
              let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") else { return UITableViewCell() }
        
        cell.textLabel?.text = sectionType.menu[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        return cell
    }
}
