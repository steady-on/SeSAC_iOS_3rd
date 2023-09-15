//
//  UIImageView+.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/28.
//

import UIKit

extension UIImageView {
    func loadTMDBData(url: String) {
        let baseURL = "https://www.themoviedb.org/t/p/w1066_and_h600_bestv2"
        
        DispatchQueue.global().async {
            guard let url = URL(string: baseURL + url),
                  let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
