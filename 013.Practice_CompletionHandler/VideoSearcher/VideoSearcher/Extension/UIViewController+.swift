//
//  UIViewController+.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/20.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "알겠어요", style: .cancel)
        
        alert.addAction(button)
        
        self.present(alert, animated: true)
    }
}
