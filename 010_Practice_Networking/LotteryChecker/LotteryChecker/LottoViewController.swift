//
//  ViewController.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/08.
//

import UIKit

class LottoViewController: UIViewController {
    
    private let viewModel = LottoViewModel()
    
    let drawingNumberPicker = UIPickerView()
    
    @IBOutlet var wrappingViews: [UIView]!
    
    @IBOutlet weak var drawingNumberTextField: UITextField!
    @IBOutlet weak var drawingNumberLabel: UILabel!
    @IBOutlet weak var drawingDate: UILabel!
    @IBOutlet var lotteryNumberLabels: [UILabel]!
    @IBOutlet weak var bonusNumberLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesignForUI()
        
        drawingNumberPicker.delegate = self
        drawingNumberPicker.dataSource = self
        
        drawingNumberTextField.inputView = drawingNumberPicker
        drawingNumberTextField.tintColor = .clear
        
        viewModel.selectedNumber.bind { value in
            self.drawingNumberTextField.text = value
            self.viewModel.textForDrawingNumberLabel()
            self.viewModel.requestLotto()
        }
        
        viewModel.seletedDrawingNumberLable.bind { text in
            self.drawingNumberLabel.text = text
        }
        
        viewModel.lotto.bind { [self] lotto in
            drawingDate.text = lotto?.drawingDate
            
            for (label, number) in zip(lotteryNumberLabels, lotto?.loteryNumber ?? []) {
                configureLabel(label, for: number)
            }

            configureLabel(bonusNumberLabel, for: lotto?.bonusNumber ?? 0)
        }
    }
    
    func setUpDesignForUI() {
        designWrappingViews()
        lotteryNumberLabels.forEach { designNumberLabel($0) }
        designNumberLabel(bonusNumberLabel)
    }
    
    func configureLabel(_ label: UILabel, for number: Int) {
        let colorName = Lotto.getColorName(for: number)
        label.setBackgroundColor(colorName)
        label.text = "\(number)"
    }
}

extension LottoViewController {
    func designWrappingViews() {
        wrappingViews.forEach {
            $0.setBackgroundColor()
            $0.setCornerRadius()
        }
    }
    
    func designNumberLabel(_ label: UILabel) {
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        label.shadowColor = .gray
        label.shadowOffset = CGSize(width: 0.5, height: 0.5)
        label.layer.cornerRadius =  label.frame.width/2
        label.layer.masksToBounds = true
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfDrawingNumbers
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.titleForRow(row)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setPickerValueToSelectedNumber(for: row)
    }
}
