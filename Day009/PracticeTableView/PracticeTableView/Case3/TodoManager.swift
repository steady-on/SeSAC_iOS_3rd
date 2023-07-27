//
//  TodoManager.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import Foundation

struct Todo: Hashable {
    let id: UUID = UUID()
    var todo: String
    var isDone: Bool = false
}

final class TodoManager {
    static var shared = TodoManager()
    
    private var todosStore = [Todo]()
    
    var todoCount: Int {
        TodoManager.shared.todosStore.count
    }
    
    var doneTodo: [Todo] {
        TodoManager.shared.todosStore.filter { $0.isDone == true }
    }
    
    var unDoneTodo: [Todo]  {
        TodoManager.shared.todosStore.filter { $0.isDone == false }
    }
    
    private init() {}
    
    static func add(_ todo: String) {
        let newTodo = Todo(todo: todo)
        shared.todosStore.insert(newTodo, at: 0)
    }
    
    static func delete(_ todoId: UUID) {
        guard let selectedTodo = shared.todosStore.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore.remove(at: selectedTodo)
    }
    
    static func toggleIsDone(_ todoId: UUID) {
        guard let selectedTodoIndex = shared.todosStore.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore[selectedTodoIndex].isDone.toggle()
    }
    
    static func modify(_ todoId: UUID, string: String) {
        guard let selectedTodoIndex = shared.todosStore.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore[selectedTodoIndex].todo = string
    }
}
