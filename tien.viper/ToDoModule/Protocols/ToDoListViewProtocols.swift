//
//  ToDoListViewProtocols.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation
import UIKit

protocol TodoListViewProtocol: AnyObject {
    
    var presenter: TodoListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showTodos(_ todos: [TodoItem])
    func showErrorMessage(_ message: String)
}

protocol TodoListPresenterProtocol: AnyObject {
    
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewWillAppear()
    func showTodoDetail(_ Todo: TodoItem)
    func addTodo(_ todo: TodoItem)
    func removeTodo(_ todo: TodoItem)
}

protocol TodoListInteractorInputProtocol: AnyObject {
    
    var presenter: TodoListInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveTodos()
    func saveTodo(_ todo: TodoItem)
    func deleteTodo(_ todo: TodoItem)
}

protocol TodoListInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didAddTodo(_ todo: TodoItem)
    func didRemoveTodo(_ todo: TodoItem)
    func didRetrieveTodos(_ todos: [TodoItem])
    func onError(message: String)
}

protocol TodoListRouterProtocol: AnyObject {
    
    static func createTodoListModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentToDoDetailScreen(from view: TodoListViewProtocol, for todo: TodoItem)
}
