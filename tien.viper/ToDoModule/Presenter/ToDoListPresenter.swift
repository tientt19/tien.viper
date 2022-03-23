//
//  ToDoListPresenter.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    
    func showTodoDetail(_ Todo: TodoItem) {
        guard let view = view else { return }
        router?.presentToDoDetailScreen(from: view, for: Todo)
    }
    
    func addTodo(_ todo: TodoItem) {
        interactor?.saveTodo(todo)
    }
    
    func viewWillAppear() {
        interactor?.retrieveTodos()
    }
    
    func removeTodo(_ todo: TodoItem) {
        interactor?.deleteTodo(todo)
    }
    
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func didAddTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
    
    func didRetrieveTodos(_ todos: [TodoItem]) {
        view?.showTodos(todos)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
    
    func didRemoveTodo(_ todo: TodoItem) {
        interactor?.retrieveTodos()
    }
}
