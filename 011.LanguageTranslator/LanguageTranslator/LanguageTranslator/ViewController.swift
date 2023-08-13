//
//  ViewController.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/12.
//

import UIKit

class ViewController: UIViewController {
    
    let sourceLanguagePicker = UIPickerView()
    let targetLanguagePicker = UIPickerView()
    
    let sourceLanguage = SourceLanguageType.allCases
    let targetLanguage = TargetLanguageType.allCases

    @IBOutlet weak var sourceLanguagePickTextField: UITextField!
    @IBOutlet weak var targetLanguagePickTextField: UITextField!
    @IBOutlet weak var swapButton: UIButton!
    
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @IBAction func swapButtonTapped(_ sender: UIButton) {
        let source = sourceLanguagePickTextField.text
        let target = targetLanguagePickTextField.text
        
        sourceLanguagePickTextField.text = target
        targetLanguagePickTextField.text = source
    }
    
    private func configureUI() {
        configureTextField()
        configurePicker()
        configureSwapButton()
        configureTextView()
        configureTranslationButton()
    }
}

extension ViewController {
    func configureSwapButton() {
        var config = UIButton.Configuration.borderedTinted()
        
        config.baseForegroundColor = .systemTeal
        config.baseBackgroundColor = .systemMint
        
        let imageConfig = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImage(systemName: "arrow.left.arrow.right", withConfiguration: imageConfig)
        config.image = image
        config.cornerStyle = .capsule
        
        swapButton.configuration = config
    }
    
    func configureTextView() {
        sourceTextView.isScrollEnabled = false
        
        targetTextView.isScrollEnabled = false
        targetTextView.isEditable = false
    }
    
    func configureTranslationButton() {
        var config = UIButton.Configuration.filled()
        
        config.title = "번역하기"
        config.baseBackgroundColor = .systemMint
        config.cornerStyle = .capsule
        config.buttonSize = .large
        
        translateButton.configuration = config
    }
}

extension ViewController: UITextFieldDelegate {
    private func configureTextField() {
        sourceLanguagePickTextField.delegate = self
        targetLanguagePickTextField.delegate = self
        
        sourceLanguagePickTextField.inputView = sourceLanguagePicker
        targetLanguagePickTextField.inputView = targetLanguagePicker
    }
    
    // MARK: 키보드 입력 막기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func configurePicker() {
        sourceLanguagePicker.delegate = self
        sourceLanguagePicker.dataSource = self
        
        targetLanguagePicker.delegate = self
        targetLanguagePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sourceLanguagePicker: return sourceLanguage.count
        case targetLanguagePicker: return targetLanguage.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sourceLanguagePicker: return sourceLanguage[row].expression
        case targetLanguagePicker: return targetLanguage[row].expression
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sourceLanguagePicker:
            let source = sourceLanguage[row]
            sourceLanguagePickTextField.text = source.expression
            swapButton.isEnabled = source == .detectLangs ? false : true
        case targetLanguagePicker:
            targetLanguagePickTextField.text = targetLanguage[row].expression
        default: break
        }
        
        view.endEditing(true)
    }
}
