//
//  MyProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class MyProfileViewController: BaseViewController {
    
    let mainView = MyProfileView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
