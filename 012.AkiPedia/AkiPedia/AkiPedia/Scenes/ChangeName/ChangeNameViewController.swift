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
        
        mainView.textField.becomeFirstResponder()
    }
    
    var profileInfo: ProfileInfo! {
        didSet {
            title = profileInfo.labelText
            mainView.fieldLabel.text = profileInfo.labelText
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tappedSaveButton))
    }
    
    @objc func tappedSaveButton() {
        
    }
}
