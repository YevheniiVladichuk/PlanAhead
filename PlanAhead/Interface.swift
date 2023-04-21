//
//  Interface.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 11/04/2023.
//

import Foundation
import UIKit

class Interface: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let selectedBackgroundView: UIView = {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        selectedBackgroundView.layer.cornerRadius = 15.0
        selectedBackgroundView.layer.masksToBounds = true
        return selectedBackgroundView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTableView()
    }
    
    required init?(coder _aDecoder: NSCoder) {
        super.init(coder: _aDecoder)
        setUpTableView()
    }
    
    func setUpTableView() {
        backgroundColor = UIColor(named: K.colors.mainBackgroundColor)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
        ])
    }
    
    func setTableViewDataSourceDelegate<D: UITableViewDataSource & UITableViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        tableView.delegate = dataSourceDelegate
        tableView.dataSource = dataSourceDelegate
        tableView.tag = row
        tableView.reloadData()
    }
    
    func configNavigationBar(navItem: UINavigationItem, maintTitle: String, rBtnTitle: String, target: Any?, rBtnAction: Selector) {
        let addButton = UIBarButtonItem(title: rBtnTitle, style: .plain, target: target, action: rBtnAction)
        navItem.rightBarButtonItem = addButton
        navItem.title = maintTitle
    }
}

