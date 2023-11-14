//
//  BaseViewController.swift
//  Rx_SamplePractice
//
//  Created by Roen White on 2023/11/14.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHiararchy()
        setConstraints()
        bind()
        configureNavigationBar()
    }

    func configureHiararchy() {
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {}
    
    func bind() {}
    
    func configureNavigationBar() {}
}
