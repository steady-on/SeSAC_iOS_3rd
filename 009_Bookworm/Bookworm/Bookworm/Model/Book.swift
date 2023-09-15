//
//  Book.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import Foundation
import RealmSwift

struct Book: Codable {
    var title: String
    var author: String
    var overview: String
    var thumbnail: String
    var statusOfReading: StatusOfReading = .notYet
    var isBookmark: Bool = false
}

enum StatusOfReading: Int, Codable, CaseIterable, PersistableEnum {
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
    
    var iconName: String {
        switch self {
        case .notYet: return "book.closed"
        case .reading: return "book"
        case .finished: return "book.closed.fill"
        }
    }
}
