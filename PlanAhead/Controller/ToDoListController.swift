//
//  ViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit
import RealmSwift

class ToDoListController: UITableViewController {
    
    let interface = Interface()
    let realm = try! Realm()
    
    var toDoItems: Results<Item>?
    var searchBar: UISearchBar!
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.colors.mainBackgroundColor)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.toDodCellId)
        
        searchBar = interface.configureSearchbar(for: tableView, withDelegate: self)
        
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Main List", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            // Показать searchBar при свайпе вниз
            tableView.tableHeaderView = searchBar
        } else {
            // Скрыть searchBar при свайпе вверх
            tableView.tableHeaderView = nil
        }
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.toDodCellId, for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.tintColor = .systemGreen
            cell.backgroundColor = UIColor(named: K.colors.cellColors)
            
            cell.accessoryType = item.done ? .checkmark: .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = toDoItems?[indexPath.row] {
                do{
                    try realm.write{
                        realm.delete(item)
                    }
                }catch {
                    print("Error deleting item: \(error)")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    // MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write{
                    item.done = !item.done
                }
            }catch {
                print("Error updating done status : \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Add New Items
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let allert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "new", style: .default) {(action) in
            //action when user clicks the "new" button on UIAlertController
            if textField.text != "" {
                if let currentCategory = self.selectedCategory {
                    do{
                        try self.realm.write{
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    }catch {
                        print("Error saving new Items with: \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        }
        allert.addTextField { (allertTexField) in
            allertTexField.placeholder = "New task"
            textField = allertTexField
        }
        
        allert.addAction(action)
        present(allert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulatiom Methods
    func loadItems() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}

// MARK: - Extensions
extension ToDoListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
        
        if searchBar.text!.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
