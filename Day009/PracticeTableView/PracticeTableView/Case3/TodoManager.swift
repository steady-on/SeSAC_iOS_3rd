//
//  TodoManager.swift
//  PracticeTableView
//
//  Created by Roen White on 2023/07/27.
//

import Foundation

final class TodoManager {
    static var shared = TodoManager()
    
    @TodoStorage(key: "todosStore") private var todosStore: [Todo]?
    
    var todoCount: Int {
        guard let todosStore = TodoManager.shared.todosStore else { return 0 }
        return todosStore.count
    }
    
    var doneTodo: [Todo] {
        guard let todosStore = TodoManager.shared.todosStore else { return [Todo]() }
        return todosStore.filter { $0.isDone == true }
    }
    
    var unDoneTodo: [Todo]  {
        guard let todosStore = TodoManager.shared.todosStore else { return [Todo]() }
        return todosStore.filter { $0.isDone == false }
    }
    
    private init() {}
    
    static func add(_ todo: String) {
        guard let todosStore = TodoManager.shared.todosStore else { return }
        let newTodo = Todo(todo: todo)

        shared.todosStore?.insert(newTodo, at: 0)
    }
    
    static func delete(_ todoId: UUID) {
        guard let selectedTodo = shared.todosStore?.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore?.remove(at: selectedTodo)
    }
    
    static func toggleIsDone(_ todoId: UUID) {
        guard let selectedTodoIndex = shared.todosStore?.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore?[selectedTodoIndex].isDone.toggle()
    }
    
    static func modify(_ todoId: UUID, string: String) {
        guard let selectedTodoIndex = shared.todosStore?.firstIndex(where: { $0.id == todoId }) else {
            print("잘못된 요청입니다.")
            return
        }
        
        shared.todosStore?[selectedTodoIndex].todo = string
    }
}
