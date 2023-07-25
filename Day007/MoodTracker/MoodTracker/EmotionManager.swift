//
//  EmotionManager.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import Foundation

final class EmotionManager {
    static var shared = EmotionManager()
    
    private var emotionData = [Emotion:Int]()
    
    var emotionCountDict: [Emotion: String] {
        return emotionData.mapValues { count in "\(count)회" }
    }
    
    private init() {}
    
    static func addValue(to emotion: Emotion) {
        shared.emotionData[emotion, default: 0] += 1
    }
    
    static func printMessageForEmotionCount(to emotion: Emotion) {
        guard let countForEmotion = shared.emotionData[emotion] else {
            print("Error! \(emotion.koreanExpression) 기분은 지금까지 체크된 적이 없어요!")
            return
        }
        
        let message = "\(emotion.koreanExpression) 기분은 지금까지 \(countForEmotion)회 체크 되었어요!"
        print(message)
    }
}