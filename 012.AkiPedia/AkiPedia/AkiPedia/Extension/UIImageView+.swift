//
//  UIImageView+.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import UIKit

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
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
