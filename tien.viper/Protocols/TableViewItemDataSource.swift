//
//  TableViewItemDataSource.swift
//  tien.viper
//
//  Created by Valerian on 23/03/2022.
//

import Foundation
import UIKit

protocol TableViewItemDataSource: AnyObject {
    var numberOfItems: Int { get }

    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}
