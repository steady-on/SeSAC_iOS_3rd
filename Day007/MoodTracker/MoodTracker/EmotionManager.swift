//
//  EmotionManager.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import Foundation

final class EmotionManager {
    private var emotionData = [Emotion:Int]()
    
    func addValue(to emotion: Emotion) {
        emotionData[emotion, default: 0] += 1
    }
    
    func printMessageForEmotionCount(to emotion: Emotion) {
        guard let countForEmotion = emotionData[emotion] else {
            print("Error! \(emotion.koreanExpression) 기분은 지금까지 체크된 적이 없어요!")
            return
        }
        
        let message = "\(emotion.koreanExpression) 기분은 지금까지 \(countForEmotion)회 체크되었어요!"
        print(message)
    }
}
