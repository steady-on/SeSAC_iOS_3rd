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
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.text = "자기소개를 적어주세요."
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .secondaryLabel
        textView.font = .preferredFont(forTextStyle: .callout)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = .zero
        return textView
    }()
    
    let editProfileButton: UIButton = {
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
        let components = [profileImageView, nicknameLabel, bioTextView, editProfileButton]
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
        
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 4),
            bioTextView.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint .activate([
            editProfileButton.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 16),
            editProfileButton.leadingAnchor.constraint(equalTo: bioTextView.leadingAnchor),
            editProfileButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40),
            editProfileButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
