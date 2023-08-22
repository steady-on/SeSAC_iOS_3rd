//
//  ViewController.swift
//  CodebaseAutolayout&UI
//
//  Created by Roen White on 2023/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var firstExampleViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Example 01", for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    lazy var secondExampleViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Example 02", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    lazy var thirdExampleViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Example 03", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let viewItems = [firstExampleViewButton, secondExampleViewButton, thirdExampleViewButton]
        viewItems.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setUpConstraints()
        
        firstExampleViewButton.addTarget(self, action: #selector(presentFirstExampleView), for: .touchUpInside)
        secondExampleViewButton.addTarget(self, action: #selector(moveToSecondExampleView), for: .touchUpInside)
    }
    
    @objc func presentFirstExampleView() {
        present(FirstExampleViewController(), animated: true)
    }
    
    @objc func moveToSecondExampleView() {
        navigationItem.backBarButtonItem = nil
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.pushViewController(SecondExampleViewController(), animated: true)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            firstExampleViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstExampleViewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstExampleViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstExampleViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstExampleViewButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3)
        ])
        
        NSLayoutConstraint.activate([
            secondExampleViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondExampleViewButton.topAnchor.constraint(equalTo: firstExampleViewButton.bottomAnchor),
            secondExampleViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondExampleViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondExampleViewButton.heightAnchor.constraint(equalTo: firstExampleViewButton.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            thirdExampleViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdExampleViewButton.topAnchor.constraint(equalTo: secondExampleViewButton.bottomAnchor),
            thirdExampleViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            thirdExampleViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            thirdExampleViewButton.heightAnchor.constraint(equalTo: firstExampleViewButton.heightAnchor)
        ])
    }
}

