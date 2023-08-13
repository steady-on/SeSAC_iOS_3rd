//
//  ViewController.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/12.
//

import UIKit

fileprivate enum WhichLang {
    case source
    case target
}

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

    private func configureUI() {
        configureTextField(sourceLanguagePickTextField, which: .source)
        configureTextField(targetLanguagePickTextField, which: .target)
    }
}

extension ViewController: UITextFieldDelegate {
    private func configureTextField(_ textField: UITextField, which: WhichLang) {
        textField.delegate = self
        
        switch which {
        case .source:
            textField.inputView = sourceLanguagePicker
        case .target:
            textField.inputView = targetLanguagePicker
        }
    }
    
    // MARK: 키보드 입력 막기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}


