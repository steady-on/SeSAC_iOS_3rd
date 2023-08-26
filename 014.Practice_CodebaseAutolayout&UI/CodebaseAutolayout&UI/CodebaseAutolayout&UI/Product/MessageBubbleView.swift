//
//  MessageBubbleView.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/23.
//

import UIKit

class MessageBubbleView: UIView {
    
    var label = UILabel()
    
    var labelText: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    var labelFont: UIFont! {
        get { label.font }
        set { label.font = newValue }
    }
    
    var labelNumberOfLines: Int {
        get { label.numberOfLines }
        set { label.numberOfLines = newValue }
    }
    
    var margins: UIEdgeInsets {
        get { layoutMargins }
        set { layoutMargins = newValue }
    }
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    convenience init(text: String) {
        self.init()
    
        self.labelText = text
        
        setDefaultDesign()
        setUpSubView()
    }
    
    private func setDefaultDesign() {
        backgroundColor = .white
        self.cornerRadius = 10
        self.labelFont = UIFont(customFont: .cafe24SupermagicRegular, size: 17)
    }
    
    private func setUpSubView() {
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
