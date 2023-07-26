//
//  Emotion.swift
//  MoodTracker
//
//  Created by Roen White on 2023/07/25.
//

import UIKit

enum Emotion: Int, CaseIterable {
    case happy
    case smile
    case soso
    case upset
    case sad
    
    var koreanExpression: String {
        switch self {
        case .happy:
            return "완전 행복한"
        case .smile:
            return "좋은"
        case .soso:
            return "그냥 그런"
        case .upset:
            return "속상한"
        case .sad:
            return "너무 슬픈"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .happy:
            return UIColor(named: "MTRed")
        case .smile:
            return UIColor(named: "MTOrange")
        case .soso:
            return UIColor(named: "MTYellow")
        case .upset:
            return UIColor(named: "MTMint")
        case .sad:
            return UIColor(named: "MTNavy")
        }
    }
}
