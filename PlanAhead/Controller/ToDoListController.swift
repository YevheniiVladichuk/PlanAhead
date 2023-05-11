//
//  ViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit
import CoreData

class ToDoListController: UITableViewController {
    
    let interface = Interface()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemsArray = [Item]()
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.toDodCellId)
        
        searchBar = interface.configureSearchbar(for: tableView, withDelegate: self)
        
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Main List", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        
        loadItems()
    }
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.toDodCellId, for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.backgroundColor = .systemPink
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        // Delete from database
        //        context.delete(itemsArray[indexPath.row])
        //        itemsArray.remove(at: indexPath.row)
        
        saveItems()
        
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
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                self.itemsArray.append(newItem)
                self.saveItems()
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
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    // func with defoult value
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
            itemsArray = try context.fetch(request)
        } catch {
            print("Error fetching context: \(error)")
        }
        
        tableView.reloadData()
    }
}


// MARK: - Extensions
extension ToDoListController: UISearchBarDelegate {
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        if searchBar.text!.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


