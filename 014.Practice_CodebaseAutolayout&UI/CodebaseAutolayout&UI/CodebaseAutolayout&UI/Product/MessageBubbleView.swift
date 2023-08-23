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
    
    convenience init(text: String,
                     backgroundColor: UIColor = .white,
                     cornerRadius:CGFloat = 10,
                     margins: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)) {
        self.init()
    
        self.label.text = text

        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layoutMargins = margins
        
        setUpSubView()
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
