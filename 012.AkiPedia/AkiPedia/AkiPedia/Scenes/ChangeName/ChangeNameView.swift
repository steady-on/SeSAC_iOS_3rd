//
//  ChangeNameView.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class ChangeNameView: BaseView {
    
    let fieldLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        let components = [fieldLabel, textField, divider]
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            fieldLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            fieldLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fieldLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: fieldLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
