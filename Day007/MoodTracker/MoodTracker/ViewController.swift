//
//  ViewController.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        guard let emotionForTagValue = Emotion(rawValue: sender.tag) else {
            print("Error! 잘못된 입력입니다.")
            return
        }
        
        EmotionManager.addValue(to: emotionForTagValue)
        EmotionManager.printMessageForEmotionCount(to: emotionForTagValue)
    }
    
}

