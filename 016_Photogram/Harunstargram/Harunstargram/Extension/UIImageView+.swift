//
//  UIImageView+.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import UIKit

extension UIImageView {
    func getDataFromUrl(url: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: url),
                  let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}

