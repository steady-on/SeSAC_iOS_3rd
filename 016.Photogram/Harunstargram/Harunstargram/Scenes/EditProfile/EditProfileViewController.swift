//
//  EditProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    private let mainView = EditProfileView()
    
    var userProfile: UserProfile!
    var delegate: DataPassDelegate?
    var changeBioHandler: ((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeNameNotificationHandler), name: NSNotification.Name.name, object: nil)
    }

    override func configureView() {
        title = "프로필 편집"
        
        mainView.infoTableView.delegate = self
        mainView.infoTableView.dataSource = self
    }
    
    @objc func changeNameNotificationHandler(_ notification: NSNotification) {
        guard let _ = notification.userInfo?["name"] as? String else { return }
        DispatchQueue.main.async {
            self.mainView.infoTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
        }
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileInfo.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileInfo = ProfileInfo(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        
        var content = UIListContentConfiguration.valueCell()
        content.text = profileInfo.labelText
        content.secondaryText = profileInfo.getValue(from: userProfile)
        content.secondaryTextProperties.color = .label
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profileInfo = ProfileInfo(rawValue: indexPath.row) else { return }
        
        switch profileInfo {
        case .name:
            let vc = ChangeNameViewController()
            self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            vc.oldValue = profileInfo.getValue(from: userProfile)
            vc.profileInfo = profileInfo
            navigationController?.pushViewController(vc, animated: true)
        case .userName:
            let vc = ChangeNameViewController()
            self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            vc.oldValue = profileInfo.getValue(from: userProfile)
            vc.profileInfo = profileInfo
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        case .bio:
            let vc = EditBioViewController()
            self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            vc.oldValue = profileInfo.getValue(from: userProfile)
            
            vc.changeBioHandler = { changedValue in
                DispatchQueue.main.async {
                    self.mainView.infoTableView.reloadRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
                }
                
                self.changeBioHandler?(changedValue)
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension EditProfileViewController: DataPassDelegate {
    func receiveChanged(data: String) {
        DispatchQueue.main.async {
            self.mainView.infoTableView.reloadRows(at: [IndexPath(item: 1, section: 0)], with: .automatic)
        }
        
        delegate?.receiveChanged(data: data)
    }
}

enum ProfileInfo: Int, CaseIterable {
    case name
    case userName
    case bio
    
    var labelText: String {
        switch self {
        case .name: return "이름"
        case .userName: return "사용자 이름"
        case .bio: return "소개"
        }
    }
    
    func getValue(from userProfile: UserProfile) -> String {
        switch self {
        case .name: return userProfile.name
        case .userName: return userProfile.userName
        case .bio: return userProfile.bio
        }
    }
}
