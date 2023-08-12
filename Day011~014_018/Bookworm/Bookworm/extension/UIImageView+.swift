//
//  UIImageView+.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
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
