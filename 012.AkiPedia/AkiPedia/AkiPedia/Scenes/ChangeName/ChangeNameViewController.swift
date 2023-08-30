//
//  ChangeNameViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class ChangeNameViewController: BaseViewController {
    
    let mainView = ChangeNameView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tappedSaveButton))
        navigationItem.backButtonTitle = nil
    }
    
    @objc func tappedSaveButton() {
        
    }
}
