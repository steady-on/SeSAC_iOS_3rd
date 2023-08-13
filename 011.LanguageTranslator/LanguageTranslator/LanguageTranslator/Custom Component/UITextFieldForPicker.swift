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
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
