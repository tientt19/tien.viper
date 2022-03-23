//
//  ListTableViewDataSource.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation
import UIKit

protocol ListTableViewDataSourceOutputs : AnyObject {
    func didSelect(_ gitHubRepository: GitHubRepository)
}

class ListTableViewDataSource : TableViewItemDataSource {

    private weak var entities : ListEntities!
    private weak var presenter : ListTableViewDataSourceOutputs?
    
    init(entities : ListEntities , presenter : ListTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }
    
    var numberOfItems: Int {
        return entities.gitHubRepositories.count
    }
    
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let repo = entities.gitHubRepositories[safe: indexPath.row] else { return UITableViewCell() }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitle")
        cell.textLabel?.text = "\(repo.fullName)"
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.text = "\(repo.description)"
        return cell
    }
    
    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

