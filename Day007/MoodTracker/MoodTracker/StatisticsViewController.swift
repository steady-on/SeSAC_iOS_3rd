//
//  StatisticsViewController.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet var emotionLabelViews: [UIView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        emotionLabelViews.forEach { view in
            view.layer.cornerRadius = 10
        }
    }
    
}
