//
//  ToDoDetailViewController.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import UIKit

class ToDoDetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    var presenter: TodoDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        presenter?.viewDidLoad()
    }
    
    func setUpView() {
        let remove = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [remove,edit]
    }
    
    @objc func deleteTapped() {
        presenter?.deleteTodo()
    }
    
    @objc func editTapped() {
        let alertController = UIAlertController(title: "Edit Todo Item", message: "Enter title and content", preferredStyle: .alert)
        
        alertController.addTextField { $0.text = self.titleLabel.text }
        alertController.addTextField { $0.text = self.contentLabel.text }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty else { return }
            self?.presenter?.editTodo(title: titleText, content: contentText)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
}

extension ToDoDetailViewController: TodoDetailViewProtocol {
    
    func showToDo(_ todo: TodoItem) {
        titleLabel.text = todo.title
        contentLabel.text = todo.content
    }
    
}
