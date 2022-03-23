//
//  ListViewController.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import UIKit

protocol ListViewInputs: AnyObject {
    func configure(entities: ListEntities)
    func reloadTableView(tableViewDataSource: ListTableViewDataSource)
    func indicatorView(animate: Bool)
}

protocol ListViewOutputs: AnyObject {
    func viewDidLoad()
    func onCloseButtonTapped()
    func onReachBottom()
}

class ListViewController: UIViewController {
    
    var presenter : ListViewOutputs?
    var tableViewDataSource : TableViewItemDataSource?
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}

extension ListViewController: ListViewInputs {
    func configure(entities: ListEntities) {
        navigationItem.title = "\(entities.entryEntity.language) Repositories"
    }
    
    func reloadTableView(tableViewDataSource: ListTableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: animate ? 50 : 0, right: 0)
            _ = animate ? self?.indicatorView.startAnimating() : self?.indicatorView.stopAnimating()
        }
    }
}

extension ListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }
}
