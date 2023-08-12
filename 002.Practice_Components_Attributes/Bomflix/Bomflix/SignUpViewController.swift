//
//  SignUpViewController.swift
//  Bomflix
//
//  Created by Roen White on 2023/07/19.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordCheck: UITextField!
    @IBOutlet var nickname: UITextField!
    
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var birthdayPicker: UIDatePicker!
    
    @IBOutlet var messageForEmailCheck: UILabel!
    @IBOutlet var messageForPasswordCheck: UILabel!
    @IBOutlet var switchLabel: UILabel!
    @IBOutlet var switchOfAdditionalInfomation: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designEmailAddress()
        designPassword(for: password)
        designPassword(for: passwordCheck)
        
        designDatePicker()
        designLabel(for: messageForEmailCheck)
        designLabel(for: messageForPasswordCheck)
        
        designSwitch()
        
        birthdayLabel.isHidden = true
        birthdayPicker.isHidden = true
    }
    
    @IBAction func checkEmailFormat(_ sender: UIButton) {
        guard let inputEmail = emailAddress.text else { return }
        let isValidEmail = checkValidEmail(inputEmail)
        
        messageForEmailCheck.isHidden = false
        
        if isValidEmail {
            messageForEmailCheck.text = "✅ 올바른 이메일 형식 입니다."
            return
        }
        
        messageForEmailCheck.text = "❌ 올바르지 않은 이메일 형식 입니다."
    }
    
    @IBAction func checkSamePassword(_ sender: UITextField) {
        let password = password.text
        let checkWord = sender.text
        
        messageForPasswordCheck.isHidden = false
        
        if password == checkWord {
            messageForPasswordCheck.text = "✅ 동일한 비밀번호 입니다."
            return
        }
        
        messageForPasswordCheck.text = "❌ 비밀번호가 동일하지 않습니다."
    }
    
    @IBAction func switchOfAdditionalInfoTapped(_ sender: UISwitch) {
        if sender.isOn {
            birthdayLabel.isHidden = false
            birthdayPicker.isHidden = false
            return
        }
        
        birthdayLabel.isHidden = true
        birthdayPicker.isHidden = true
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func checkValidEmail(_ string: String) -> Bool {
        if string.count > 100 { return false }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func designLabel(for label: UILabel) {
        label.isHidden = true
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
    }
    
    func designDatePicker() {
        birthdayPicker.maximumDate = Date()
        birthdayPicker.preferredDatePickerStyle = .compact
        birthdayPicker.backgroundColor = .systemGray6
    }
    
    func designEmailAddress() {
        emailAddress.placeholder = "이메일 주소 입력"
        emailAddress.keyboardType = .emailAddress
        emailAddress.textAlignment = .left
//        emailAddress.borderStyle = .roundedRect
//        emailAddress.layer.cornerRadius = 5
//        emailAddress.layer.borderWidth = 1.5
    }
    
    func designPassword(for textFeild: UITextField) {
        textFeild.placeholder = "비밀번호"
        textFeild.isSecureTextEntry = true
    }
    
    func designSwitch() {
        switchLabel.text = "추가정보 입력"
        switchLabel.textColor = .white
        
        switchOfAdditionalInfomation.isOn = false
        switchOfAdditionalInfomation.onTintColor = .systemPink
    }
}
