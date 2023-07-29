//
//  ViewController.swift
//  MoviewTableView
//
//  Created by Roen White on 2023/07/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

extension ViewController {
    func designSearchTextField() {
        searchTextField.font = .preferredFont(forTextStyle: .body)
        searchTextField.textAlignment = .left
        searchTextField.placeholder = "영화 제목을 입력해주세요."
        searchTextField.borderStyle = .none
        searchTextField.clearButtonMode = .always
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        searchTextField.returnKeyType = .go
    }
}
