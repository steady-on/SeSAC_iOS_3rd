//
//  LaboratoryViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class LaboratoryViewController: BaseViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.borderedProminent()
        config.title = "값 변경!"
        button.configuration = config
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "값 입력"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHiararchy() {
        super.configureHiararchy()
        
        let components = [textField, button, label]
        components.forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
