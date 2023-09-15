//
//  UIImageView+.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import UIKit

extension UIImageView {
    func loadData(url: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: url),
                  let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
