//
//  ViewController.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    var presenter: TodoListPresenterProtocol?
    var todos: [TodoItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet private weak var tableView : UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // báo cho Presenter rằng view chuẩn bị được hiện ra và cần thực hiện 1 cái gì đó
        presenter?.viewWillAppear()
    }
    
    private func setupView() {
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
        tableView.tableFooterView = UIView()
    }
    
    @objc func addTapped() {
        let alertController = UIAlertController(title: "Add Todo Item", message: "Enter title and content", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty else { return }
            let todoItem = TodoItem(title: titleText, content: contentText)
            // báo cho present có sự kiện người dùng add item và cần được xử lý
            self?.presenter?.addTodo(todoItem)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension ToDoListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        // báo cho presenter người dùng tap để xem detail
        presenter?.showTodoDetail(todo)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoItem = todos[indexPath.row]
            // báo cho presenter người dùng ấn xoá item và cần được xử lý
            presenter?.removeTodo(todoItem)
        }
    }
    
}

extension ToDoListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.content
        return cell
    }
    
}

extension ToDoListViewController: TodoListViewProtocol {
    
    func showTodos(_ todos: [TodoItem]) {
        self.todos = todos
    }
    
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
