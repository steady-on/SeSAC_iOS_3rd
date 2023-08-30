//
//  MyProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class UserProfile {
    var name: String
    var userName: String
    var bio: String
    
    init(name: String, userName: String, bio: String) {
        self.name = name
        self.userName = userName
        self.bio = bio
    }
}

class MyProfileViewController: BaseViewController {
    
    var userProfile = UserProfile(name: "Roen", userName: "_steady_on", bio: "I'm Roen and Apple platform developer.")
    
    let mainView = MyProfileView()
    
    var userId: String {
        userProfile.userName
    }
    
    lazy var userIdLabel: UIBarButtonItem = {
        let label = UILabel()
        label.text = userId
        label.font = .boldSystemFont(ofSize: 22)
        
        return UIBarButtonItem(customView: label)
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() {        
        navigationItem.hidesBackButton = true
        navigationItem.setLeftBarButton(userIdLabel, animated: true)
        
        mainView.editProfileButton.addTarget(self, action: #selector(tappedEditProfileButton), for: .touchUpInside)
        
        mainView.nicknameLabel.text = userProfile.name
        mainView.bioTextView.text = userProfile.bio
    }
    
    @objc func tappedEditProfileButton() {
        let vc = EditProfileViewController()
        vc.userProfile = userProfile
        navigationController?.pushViewController(vc, animated: true)
    }
}
