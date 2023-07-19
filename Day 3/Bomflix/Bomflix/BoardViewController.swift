//
//  BoardViewController.swift
//  Bomflix
//
//  Created by Roen White on 2023/07/19.
//

import UIKit

class BoardViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var boardTextField: UITextField!
    @IBOutlet var inputButton: UIButton!
    @IBOutlet var hiddenStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        boardTextField.delegate = self
        boardTextField.returnKeyType = .done
        
        designHiddenStateLabel()
        
        designResultLabel()
        designBoardTextField()
    }
    
    @IBAction func textFieldEndOnExit(_ sender: UITextField) {
        print("지금!")
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let inputText = boardTextField.text
        resultLabel.text = inputText
        boardTextField.text = ""
    }
    
    // 탭 제스처를 활용해서 키보드 내리기
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
        if boardTextField.isHidden == false {
            boardTextField.isHidden = true
            inputButton.isHidden = true
            hiddenStateLabel.isHidden = false
            return
        }
        
        boardTextField.isHidden = false
        inputButton.isHidden = false
        hiddenStateLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkButtonClicked(inputButton)
        return true
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
        boardTextField.textColor = .systemIndigo
    }
    
    func designHiddenStateLabel() {
        hiddenStateLabel.isHidden = true
        hiddenStateLabel.textColor = .systemGray2
        hiddenStateLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        hiddenStateLabel.textAlignment = .center
        hiddenStateLabel.text = "화면을 탭하면 입력창이 나타납니다."
    }
}
