//
//  ViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit

class MainUITableViewController: UITableViewController {
    
    let interface = Interface()
    let id = "ToDoItemCell"
    let items = ["List 1", "List 2", "List 3"]
    
    override func loadView() {
        super.loadView()
        view = interface
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interface.tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Main List", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        interface.setTableViewDataSourceDelegate(self, forRow: 0)
    }
    
    @objc func addButtonPressed(_ sender: UINavigationItem) {
        print("pressed")
    }
    
    // MARK: - TableView Datasource Methods
    
    // create cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        cell.textLabel?.text = items[indexPath.section]
        cell.backgroundColor = .systemPink
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        //внутрішні розмежування
        cell.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return cell
    }
    
    // MARK: - TableView Delegate Method
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // view for header in section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
          headerView.backgroundColor = UIColor.clear
          return headerView
      }
    
    // did select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        
        //set up selected background
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = interface.selectedBackgroundView
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //spacing between
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}
    

    
