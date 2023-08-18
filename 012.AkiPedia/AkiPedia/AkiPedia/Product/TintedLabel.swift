//
//  TintedLabel.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import UIKit

// 코드 참고 url: https://ios-development.tistory.com/698

class TintedLabel: UILabel {
    private var padding = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    
    convenience init(padding: UIEdgeInsets
                     = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
