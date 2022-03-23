//
//  ToDoListRouter.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation
import UIKit

class TodoListRouter: TodoListRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createTodoListModule() -> UIViewController {
        let navController = storyboard.instantiateViewController(withIdentifier: "TodoListNavigation") as! UINavigationController
        guard let todoListViewController = navController.topViewController as? ToDoListViewController else { fatalError("Invalid View Controller") }
        
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router = TodoListRouter()
        
        todoListViewController.presenter = presenter
        presenter.view = todoListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
    }

    
    func presentToDoDetailScreen(from view: TodoListViewProtocol, for todo: TodoItem) {
        
        let todoDetailVC = TodoDetailRouter.createTodoDetailRouterModule(with: todo)

        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }

        viewVC.navigationController?.pushViewController(todoDetailVC, animated: true)
    }
    
}
