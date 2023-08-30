//
//  EditBioView.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class EditBioView: BaseView {
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()

    override func configureView() {
        super.configureView()
        
        let components = [bioTextView, divider]
        
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bioTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 4),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
}
