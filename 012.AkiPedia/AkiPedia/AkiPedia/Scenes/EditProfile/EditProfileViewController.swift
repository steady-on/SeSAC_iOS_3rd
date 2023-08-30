//
//  EditProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    private let mainView = EditProfileView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() {
        title = "프로필 편집"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tappedCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(tappedDoneButton))
        
        mainView.infoTableView.delegate = self
        mainView.infoTableView.dataSource = self
    }
    
    @objc private func tappedCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedDoneButton() {
        
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
        content.secondaryText = "프로필 내용이 들어갈 자리"
        content.secondaryTextProperties.color = .label
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profileInfo = ProfileInfo(rawValue: indexPath.row) else { return }
        
        switch profileInfo {
        case .name, .userName:
            let vc = ChangeNameViewController()
            self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            vc.profileInfo = profileInfo
            navigationController?.pushViewController(vc, animated: true)
        case .bio:
            break
        }
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
}
