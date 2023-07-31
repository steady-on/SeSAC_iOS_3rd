//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "도서 검색"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

