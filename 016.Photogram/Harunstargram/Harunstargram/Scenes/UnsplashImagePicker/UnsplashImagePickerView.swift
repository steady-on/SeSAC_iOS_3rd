//
//  UnsplashImagePickerView.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import UIKit

class UnsplashImagePickerView: BaseView {
    let nothingLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func configureView() {
        super.configureView()
        
        let components = [nothingLabel]
        components.forEach { component in
            addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            nothingLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            nothingLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

extension UnsplashImagePickerView: UISearchBarDelegate {
    
}
