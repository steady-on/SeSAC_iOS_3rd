//
//  UIFont+.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/22.
//

import UIKit

extension UIFont {
    enum CustomFont: String {
        case cafe24SupermagicRegular
        case cafe24SupermagicBold
        
        var fontName: String {
            switch self {
            case .cafe24SupermagicBold: return "Cafe24Supermagic-Bold"
            case .cafe24SupermagicRegular: return "Cafe24Supermagic-Regular"
            }
        }
    }
    
    convenience init?(customFont: CustomFont, size: CGFloat) {
        self.init(name: customFont.fontName, size: size)
    }
}


