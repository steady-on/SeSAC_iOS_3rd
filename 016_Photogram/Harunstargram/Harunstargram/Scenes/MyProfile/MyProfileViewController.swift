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
    
    let userProfile = UserProfile(name: "Roen", userName: "_steady_on", bio: "I'm Roen and Apple platform developer.")
    
    let mainView = MyProfileView()
    
    var userId: String { userProfile.userName }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNameNotificationHandler), name: NSNotification.Name.name, object: nil)
    }

    override func configureView() {        
        navigationItem.hidesBackButton = true
        let userIdLabel = makeNavigationBarUserNameLabel()
        navigationItem.setLeftBarButton(userIdLabel, animated: true)
        
        mainView.editProfileButton.addTarget(self, action: #selector(tappedEditProfileButton), for: .touchUpInside)
        
        mainView.nicknameLabel.text = userProfile.name
        mainView.bioTextView.text = userProfile.bio
    }
    
    @objc func changeNameNotificationHandler(_ notification: NSNotification) {
        guard let name = notification.userInfo?["name"] as? String else { return }
        userProfile.name = name
        mainView.nicknameLabel.text = name
    }
    
    @objc func tappedEditProfileButton() {
        let vc = EditProfileViewController()
        vc.userProfile = userProfile
        vc.delegate = self
        vc.changeBioHandler = { chagedBio in
            self.userProfile.bio = chagedBio
            self.mainView.bioTextView.text = chagedBio
        }
        
        vc.selectImageFromUnsplashHandler = { url in
            self.mainView.profileImageView.getDataFromUrl(url: url)
        }
        
        vc.selectImageFromGalaryHandler = { image in
            self.mainView.profileImageView.image = image
        }
        
        vc.profileImage = mainView.profileImageView.image
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func makeNavigationBarUserNameLabel() -> UIBarButtonItem {
        let label = UILabel()
        label.text = userId
        label.font = .boldSystemFont(ofSize: 22)
        
        return UIBarButtonItem(customView: label)
    }
}

extension MyProfileViewController: DataPassDelegate {
    func receiveChanged(data: String) {
        userProfile.userName = data
        let userIdLabel = makeNavigationBarUserNameLabel()
        navigationItem.setLeftBarButton(userIdLabel, animated: true)
    }
}
