//
//  TodoSectionType.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import Foundation

enum TodoSectionType: Int, CaseIterable {
    case unDone
    case done
    
    var title: String {
        switch self {
        case .unDone:
            return "미완료"
        }
        case .done:
            return "완료"
    }
}
