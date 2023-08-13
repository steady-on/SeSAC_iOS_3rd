//
//  UITextFieldForPicker.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/13.
//

import UIKit

class UITextFieldForPicker: UITextField {
    override var tintColor: UIColor! {
        get { return .clear }
        set {  }
    }
    
    // MARK: UITextField 메뉴(복사, 붙여넣기 등) 띄우지 않기
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
