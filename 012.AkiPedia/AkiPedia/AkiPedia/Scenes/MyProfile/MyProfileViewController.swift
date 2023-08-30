//
//  MyProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/29.
//

import UIKit

class MyProfileViewController: BaseViewController {
    
    let mainView = MyProfileView()
    
    var userId: String = "아이디를 설정해주세요"
    
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
    }
    
    @objc func tappedEditProfileButton() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
