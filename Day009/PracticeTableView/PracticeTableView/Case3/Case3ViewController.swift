//
//  Case3ViewController.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import UIKit

class Case3ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let inputText = inputTextField.text else { return }
        view.endEditing(true)
        TodoManager.add(inputText)
        inputTextField.text = ""
        todoTableView.reloadData()
    }
    
    @IBAction func tappedReturnKeyInsideTextField(_ sender: UITextField) {
        addButtonTapped(addButton)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = TodoSectionType(rawValue: indexPath.section) else { return }
        
        switch sectionType {
        case .unDone:
            let todo = TodoManager.shared.unDoneTodo[indexPath.row]
            TodoManager.toggleIsDone(todo.id)
        case .done:
            let todo = TodoManager.shared.doneTodo[indexPath.row]
            TodoManager.toggleIsDone(todo.id)
        }
        tableView.reloadData()
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
            unDoneTodoCell.textLabel?.text = TodoManager.shared.unDoneTodo[indexPath.row].todo
            return unDoneTodoCell
        case .done:
            doneTodoCell.textLabel?.text = TodoManager.shared.doneTodo[indexPath.row].todo
            return doneTodoCell
        }
    }
}
