//
//  MessageBubbleView.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/23.
//

import UIKit

class MessageBubbleView: UIView {
    
    private var label = UILabel()
    
    var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    var font: UIFont! {
        get { label.font }
        set { label.font = newValue }
    }
    
    var numberOfLines: Int {
        get { label.numberOfLines }
        set { label.numberOfLines = newValue }
    }
    
    var margins: NSDirectionalEdgeInsets {
        get { directionalLayoutMargins }
        set { directionalLayoutMargins = newValue }
    }
    
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    convenience init(text: String) {
        self.init()
    
        self.text = text
        
        setDefaultDesign()
        setUpSubView()
    }
    
    private func setDefaultDesign() {
        backgroundColor = .white
        self.cornerRadius = 10
        self.font = UIFont(customFont: .cafe24SupermagicRegular, size: 17)
        self.numberOfLines = 0
    }
    
    private func setUpSubView() {
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
