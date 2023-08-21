//
//  MediaTypeLabel.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import UIKit

class MediaTypeLabel: UILabel {
    var insetPadding = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    
    
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insetPadding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insetPadding.top + insetPadding.bottom
        contentSize.width += insetPadding.left + insetPadding.right
        
        return contentSize
    }
}
