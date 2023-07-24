//
//  ViewController.swift
//  LEDBoard
//
//  Created by Roen White on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var textColorPicker: UIColorWell!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var informationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let inputText = inputTextField.text,
              inputText.isEmpty == false else {
            return
        }
        
        textLabel.text = inputText
        textLabel.textColor = textColorPicker.selectedColor
        
        view.endEditing(true)
    }
    
    @IBAction func inputReturnKeyToTextField(_ sender: UITextField) {
        doneButtonTapped(inputButton)
    }
    
    @IBAction func screenTapGesture(_ sender: UITapGestureRecognizer) {
        if inputTextField.isEditing {
            view.endEditing(true)
        } else {
            inputStackView.isHidden.toggle()
            informationLabel.isHidden.toggle()
        }
    }
    
    func setUpUI() {
        inputStackView.layer.cornerRadius = 5
        
        inputButton.layer.cornerRadius = 5
        
        inputTextField.placeholder = "내용을 입력해주세요."
        
        textLabel.textColor = textColorPicker.selectedColor
        textLabel.text = ""
        
        informationLabel.isHidden = true
    }
}

