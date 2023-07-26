//
//  ViewController.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emotionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (button, emotion) in zip(emotionButtons, Emotion.allCases) {
            button.tintColor = emotion.color
        }
        
        emotionButtons.forEach { button in
            setPullDownAction(to: button)
        }
    }

    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        guard let emotionForTagValue = Emotion(rawValue: sender.tag) else {
            print("Error! 잘못된 입력입니다.")
            return
        }
        
        EmotionManager.addValue(to: emotionForTagValue)
        EmotionManager.printMessageForEmotionCount(to: emotionForTagValue)
    }
    
    func setPullDownAction(to button: UIButton) {
        let plusFive = UIAction(title: "+5", image: UIImage(systemName: "plus.circle")) { _ in
            guard let selectedEmotion = Emotion(rawValue: button.tag) else { return }
            
            EmotionManager.addValue(to: selectedEmotion, count: 5)
            EmotionManager.printMessageForEmotionCount(to: selectedEmotion)
        }
        
        let plusTen = UIAction(title: "+10", image: UIImage(systemName: "plus.circle.fill")) { _ in
            guard let selectedEmotion = Emotion(rawValue: button.tag) else { return }
            
            EmotionManager.addValue(to: selectedEmotion, count: 10)
            EmotionManager.printMessageForEmotionCount(to: selectedEmotion)
        }
        
        let resetData = UIAction(title: "기록 초기화", subtitle: "해당 기분의 기록 초기화", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            guard let selectedEmotion = Emotion(rawValue: button.tag) else { return }
            
            EmotionManager.resetData(of: selectedEmotion)
            EmotionManager.printMessageForEmotionCount(to: selectedEmotion)
        }
        
        button.menu = UIMenu(options: .displayInline, children: [plusFive, plusTen, resetData])
    }
}

