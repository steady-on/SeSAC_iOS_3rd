//
//  Emotion.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import Foundation

enum Emotion: Int {
    case happy
    case smile
    case soso
    case upset
    case sad
    
    var koreanExpression: String {
        switch self {
        case .happy:
            return "완전행복한"
        case .smile:
            return "좋은"
        case .soso:
            return "그냥그런"
        case .upset:
            return "속상한"
        case .sad:
            return "너무슬픈"
        }
    }
}
