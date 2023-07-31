//
//  Book.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import Foundation

struct Book: Codable {
    var title: String
    var author: String
    var stateOfReading: StateOfReading.RawValue
    var isBookmark: Bool
}

enum StateOfReading: Int {
    case notYet
    case reading
    case finished
    
    var expression: String {
        switch self {
        case .notYet: return "아직 안 읽음"
        case .reading: return "읽는 중"
        case .finished: return "다 읽음"
        }
    }
}
