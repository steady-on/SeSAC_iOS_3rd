//
//  StatisticsViewController.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet var emotionLabelViews: [UIView]!
    
    @IBOutlet var emotionStringLabels: [UILabel]!
    
    @IBOutlet var numbersOfEmotionTapped: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let emotionCountDict = EmotionManager.shared.emotionCountDict

        for (label, emotion) in zip(numbersOfEmotionTapped, Emotion.allCases) {
            label.text = emotionCountDict[emotion] ?? "0회"
        }
    }
    
    func setUI() {
        emotionLabelViews.forEach { view in
            view.layer.cornerRadius = 10
        }
        
        for (label, emotion) in zip(emotionStringLabels, Emotion.allCases) {
            label.text = emotion.koreanExpression
        }
        
        let emotionCountDict = EmotionManager.shared.emotionCountDict

        for (label, emotion) in zip(numbersOfEmotionTapped, Emotion.allCases) {
            label.text = emotionCountDict[emotion] ?? "0회"
        }
    }
    
}
