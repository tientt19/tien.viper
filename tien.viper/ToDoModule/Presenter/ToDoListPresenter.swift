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
        // yêu cầu router thực hiện chuyển vc.
        router?.presentToDoDetailScreen(from: view, for: Todo)
    }
    
    func addTodo(_ todo: TodoItem) {
        // nhận được thông báo add item từ user và chuyển cho interactor thực hiện.
        interactor?.saveTodo(todo)
    }
    
    func viewWillAppear() {
        // nhận được thông báo và chuyển cho interactor lấy dữ liệu và hiện cho người dùng.
        interactor?.retrieveTodos()
    }
    
    func removeTodo(_ todo: TodoItem) {
        // nhận được thông báo xoá dữ liệu và chuyển cho interactor thực hiện tác vụ.
        interactor?.deleteTodo(todo)
    }
    
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func didAddTodo(_ todo: TodoItem) {
        // update ui message
        interactor?.retrieveTodos()
    }
    
    func didRetrieveTodos(_ todos: [TodoItem]) {
        // update ui message
        view?.showTodos(todos)
    }
    
    func onError(message: String) {
        // update ui message
        view?.showErrorMessage(message)
    }
    
    func didRemoveTodo(_ todo: TodoItem) {
        // update ui message
        interactor?.retrieveTodos()
    }
}
