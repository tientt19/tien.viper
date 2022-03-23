//
//  ToDoDetailRouter.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation
import UIKit

class TodoDetailRouter: TodoDetailRouterProtocol {
    
    func navigateBackToListViewController(from view: TodoDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoDetailRouterModule(with todo: TodoItem) -> UIViewController {
        
        let todoDetailVC = ToDoDetailViewController()
        
        let presenter: TodoDetailPresenter & TodoDetailInteractorOutputProtocol = TodoDetailPresenter()
        todoDetailVC.presenter = presenter
        presenter.view = todoDetailVC
        let interactor: TodoDetailInteractorInputProtocol = TodoDetailInteractor()
        interactor.todoItem = todo
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: TodoDetailRouterProtocol = TodoDetailRouter()
        presenter.router = router
        
        return todoDetailVC
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
