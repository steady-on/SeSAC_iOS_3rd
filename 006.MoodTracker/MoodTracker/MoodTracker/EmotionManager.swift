//
//  EmotionManager.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import Foundation

final class EmotionManager {
    static var shared = EmotionManager()
    
    private var emotionData: [String:Int] {
        get {
            UserDefaults.standard.dictionary(forKey: "emotionData") as? [String:Int] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "emotionData")
        }
    }
    
    var emotionCountDict: [String: String] {
        return emotionData.mapValues { count in "\(count)회" }
    }
    
    private init() {}
    
    static func addValue(to emotion: Emotion) {
        shared.emotionData[emotion.koreanExpression, default: 0] += 1
    }
    
    static func addValue(to emotion: Emotion, count: Int) {
        shared.emotionData[emotion.koreanExpression, default: 0] += count
    }
    
    static func resetData(of emotion: Emotion) {
        shared.emotionData[emotion.koreanExpression] = nil
    }
    
    static func printMessageForEmotionCount(to emotion: Emotion) {
        guard let countForEmotion = shared.emotionData[emotion.koreanExpression] else {
            print("Error! \(emotion.koreanExpression) 기분은 지금까지 체크된 적이 없어요!")
            return
        }
        
        let message = "\(emotion.koreanExpression) 기분은 지금까지 \(countForEmotion)회 체크 되었어요!"
        print(message)
    }
}
