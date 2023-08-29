//
//  MyProfileView.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class MyProfileView: BaseView {
    lazy var profileImageView: ProfileImageView = {
        let imageView = ProfileImageView(frame: .init(x: 0, y: 0, width: 200, height: 200))
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nickname"
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 1
        return label
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.borderedTinted()
        config.baseBackgroundColor = .lightGray
        config.baseForegroundColor = .white
        config.title = "프로필 수정"
        config.image = UIImage(systemName: "pencil")
        config.imagePadding = 8
        
        button.configuration = config
        
        return button
    }()
    
    override func configureView() {
        super.configureView()
        let components = [profileImageView, nicknameLabel, profileEditButton]
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1),
            profileImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            nicknameLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint .activate([
            profileEditButton.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 16),
            profileEditButton.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            profileEditButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileEditButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
