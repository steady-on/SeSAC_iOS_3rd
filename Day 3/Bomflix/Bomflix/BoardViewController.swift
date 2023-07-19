//
//  BoardViewController.swift
//  Bomflix
//
//  Created by Roen White on 2023/07/19.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet var testLabel: [UILabel]!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var boardTextField: UITextField!
    @IBOutlet var inputButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in testLabel {
            item.textColor = .red
            item.font = .boldSystemFont(ofSize: 15)
        }
        
        designResultLabel()
        designBoardTextField()
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let inputText = boardTextField.text
        resultLabel.text = inputText
        boardTextField.text = ""
    }
    
    // 탭 제스처를 활용해서 키보드 내리기
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func designResultLabel() {
        resultLabel.textAlignment = .center
        resultLabel.text = "안녕하세요"
        resultLabel.font = .boldSystemFont(ofSize: 50)
        resultLabel.textColor = .systemIndigo
        resultLabel.numberOfLines = 3
    }
    
    func designBoardTextField() {
        boardTextField.placeholder = "내용을 입력해주세요"
        boardTextField.textColor = .brown
        boardTextField.keyboardType = .emailAddress
        boardTextField.borderStyle = .line
    }
}
