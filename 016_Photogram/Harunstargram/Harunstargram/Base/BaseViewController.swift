//
//  BaseViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setConstraints()
    }
    
    func configureView() {}
    func setConstraints() {}
}
