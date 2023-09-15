//
//  UIView+.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/09.
//

import UIKit

extension UIView {
    func setBackgroundColor(_ name: String = "BackgroundColor") {
        self.backgroundColor = UIColor(named: name)
    }
    
    func setCornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
}
