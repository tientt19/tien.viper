//
//  ToDoListInteractor.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation

class TodoListInteractor: TodoListInteractorInputProtocol {
    
    weak var presenter: TodoListInteractorOutputProtocol?
    var todoStore = TodoStore.shared
    
    var todos: [TodoItem] {
        return todoStore.todos
    }
    
    func retrieveTodos() {
        // đã hoàn tất việc lấy dữ liệu và thông báo cho preseter để update ui.
        presenter?.didRetrieveTodos(todos)
    }
    
    func saveTodo(_ todo: TodoItem) {
        // đã hoàn tất việc lấy dữ liệu và thông báo cho preseter để update ui.
        todoStore.addTodo(todo)
        presenter?.didAddTodo(todo)
    }
    
    func deleteTodo(_ todo: TodoItem) {
        // đã hoàn tất việc lấy dữ liệu và thông báo cho preseter để update ui.
        todoStore.removeTodo(todo)
        presenter?.didRemoveTodo(todo)
    }
    
}
