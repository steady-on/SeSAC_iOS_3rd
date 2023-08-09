//
//  ViewController.swift
//  PracticeNetworking
//
//  Created by Roen White on 2023/08/08.
//

import UIKit

class LottoViewController: UIViewController {
    
    @IBOutlet var wrappingViews: [UIView]!
    
    @IBOutlet weak var drawingNumberTextField: UITextField!
    @IBOutlet weak var drawingNumberLabel: UILabel!
    @IBOutlet weak var drawingDate: UILabel!
    
    @IBOutlet var lotteryNumberButtons: [UIButton]!
    @IBOutlet weak var bonusNumberButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDesignForUI()
        
    }
    
    func setUpDesignForUI() {
        designWrappingViews()
        lotteryNumberButtons.forEach { designNumberButton($0) }
        designNumberButton(bonusNumberButton)
    }
    
    func configureButton(_ button: UIButton, for number: Int) {
        let imageName = ""
        
        button.setTitle("\(number)", for: .disabled)
        button.setBackgroundImage(UIImage(named: imageName), for: .disabled)
    }
}

extension LottoViewController {
    func designWrappingViews() {
        wrappingViews.forEach {
            $0.setBackgroundColor()
            $0.setCornerRadius()
        }
    }
    
    func designNumberButton(_ button: UIButton) {
        button.isEnabled = true
        button.setTitleColor(.white, for: .disabled)
    }
}
