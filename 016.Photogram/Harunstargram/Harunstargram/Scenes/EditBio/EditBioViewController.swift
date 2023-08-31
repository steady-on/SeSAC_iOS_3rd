//
//  EditBioViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class EditBioViewController: BaseViewController {
    
    let mainView = EditBioView()
    
    var oldValue: String!
    var changeBioHandler: ((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tappedSaveButton))
        
        mainView.bioTextView.text = oldValue
    }
    
    @objc func tappedSaveButton() {
        guard let text = mainView.bioTextView.text else { return }
        changeBioHandler?(text)
        
        navigationController?.popViewController(animated: true)
    }
}
