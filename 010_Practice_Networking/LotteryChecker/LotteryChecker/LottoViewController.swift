//
//  ViewController.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/08.
//

import UIKit
import RxSwift
import RxCocoa

class LottoViewController: UIViewController {
    
    private let viewModel = LottoViewModel()
    
    let drawingNumberPicker = UIPickerView()
    
    @IBOutlet var wrappingViews: [UIView]!
    
    @IBOutlet weak var drawingNumberTextField: UITextField!
    @IBOutlet weak var drawingNumberLabel: UILabel!
    @IBOutlet weak var drawingDate: UILabel!
    @IBOutlet var lotteryNumberLabels: [UILabel]!
    @IBOutlet weak var bonusNumberLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesignForUI()
        
        bind()
        
        drawingNumberTextField.inputView = drawingNumberPicker
        drawingNumberTextField.tintColor = .clear
    }
    
    private func bind() {
        // ???: 근데 맨처음 기본 값은 어떻게 넣지?
        
        // UIPickerViewDataSource; numberOfRowsInComponent, titleForRow
        viewModel.drawingNumbers
            .bind(to: drawingNumberPicker.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        // UIPickerViewDelegate; didSelectRow
        drawingNumberPicker.rx.modelSelected(String.self)
            .map { $0[0] }
            .bind(with: self) { owner, value in
                owner.drawingNumberTextField.text = value
                owner.drawingNumberLabel.text = "\(value)회 당첨 결과"
            }
            .disposed(by: disposeBag)
        
        drawingNumberPicker.rx.modelSelected(String.self)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { $0[0] }
            .flatMap {
                self.viewModel.requestLotto(selectedNumber: $0)
            }
            .subscribe(with: self) { owner, lotto in
                owner.drawingNumberTextField.resignFirstResponder()
                owner.drawingDate.text = lotto.drawingDate
                
                for (label, number) in zip(owner.lotteryNumberLabels, lotto.loteryNumber) {
                    owner.configureLabel(label, for: number)
                }
                
                owner.configureLabel(owner.bonusNumberLabel, for: lotto.bonusNumber)
            } onError: { owner, error in
                owner.drawingNumberLabel.text = "회차 정보를 불러오지 못했습니다."
            }
            .disposed(by: disposeBag)
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
