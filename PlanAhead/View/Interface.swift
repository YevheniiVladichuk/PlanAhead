//
//  Interface.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 11/04/2023.
//

import Foundation
import UIKit

class Interface {
         
//    func configViews(tableView: UITableView, view: UIView) {
//        view.backgroundColor = UIColor(named: K.colors.mainBackgroundColor)
//        tableView.separatorStyle = .none
//    }
    
    func configureSearchbar(for tableView: UITableView, withDelegate delegate: UISearchBarDelegate)-> UISearchBar {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 56))
        searchBar.placeholder = "Search"
        searchBar.delegate = delegate
        tableView.tableHeaderView = searchBar
        return searchBar
    }
    
    func configNavigationBar(navItem: UINavigationItem, maintTitle: String, rBtnTitle: String, target: Any?, rBtnAction: Selector) {
        let addButton = UIBarButtonItem(title: rBtnTitle, style: .plain, target: target, action: rBtnAction)
        navItem.rightBarButtonItem = addButton
        navItem.title = maintTitle
    }
}

