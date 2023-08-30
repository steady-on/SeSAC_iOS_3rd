//
//  ChangeNameViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class ChangeNameViewController: BaseViewController {
    
    let mainView = ChangeNameView()
    
    var oldValue: String!
    
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
            mainView.textField.text = self.oldValue
        }
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tappedSaveButton))
    }
    
    @objc func tappedSaveButton() {
        guard let name = mainView.textField.text else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name.name, object: nil, userInfo: ["name": name])
        
        navigationController?.popViewController(animated: true)
    }
}
