//
//  ToDoPresenter.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation

class TodoDetailPresenter: TodoDetailPresenterProtocol {

    weak var view: TodoDetailViewProtocol?
    var router: TodoDetailRouterProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    
    
    func viewDidLoad() {
        if let todoItem = interactor?.todoItem {
            view?.showToDo(todoItem)
        }
    }
    
    func editTodo(title: String, content: String) {
        interactor?.editTodo(title: title, content: content)
    }
    
    func deleteTodo() {
        interactor?.deleteTodo()
    }
    
}

extension TodoDetailPresenter: TodoDetailInteractorOutputProtocol {
    
    func didDeleteTodo() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    func didEditTodo(_ todo: TodoItem) {
        view?.showToDo(todo)
    }
    
}
