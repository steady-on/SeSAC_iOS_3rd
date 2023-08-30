//
//  EditProfileView.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class EditProfileView: BaseView {
    lazy var profileImageView: ProfileImageView = {
        let imageView = ProfileImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        return imageView
    }()
    
    let editPictureButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "프로필 사진 수정"
        config.buttonSize = .small
        
        button.configuration = config
        
        return button
    }()
    
    lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func configureView() {
        super.configureView()
        
        let components = [profileImageView, editPictureButton, infoTableView]
        
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1),
            profileImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            editPictureButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            editPictureButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: editPictureButton.bottomAnchor, constant: 16),
            infoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoTableView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

