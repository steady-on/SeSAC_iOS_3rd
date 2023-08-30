//
//  EditProfileViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/30.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    let mainView = EditProfileView()
    
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
    
    @objc func tappedCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedDoneButton() {
        
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = UIListContentConfiguration.valueCell()
        content.text = "테스트제목"
        content.secondaryText = "프로필 내용이 들어갈 자리"
        content.secondaryTextProperties.color = .label
        cell.contentConfiguration = content
        
        return cell
    }
}
