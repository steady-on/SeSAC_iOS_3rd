//
//  Todo.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/28.
//

import Foundation

struct Todo {
    let id: UUID = UUID()
    var todo: String
    var isDone: Bool = false
}

extension Todo: Encodable {}
