//
//  ViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/04/2023.
//

import UIKit

class MainUITableViewController: UITableViewController {
    
    let interface = Interface()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemsArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Main List", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.id)
        
        loadItems()
    }
    
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.id, for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.backgroundColor = .systemPink
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        return cell
    }
    
    // MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Add new items
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let allert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "new", style: .default) {(action) in
            //action when user clicks the "new" button on UIAlertController
            if textField.text != "" {
                
                let newItem = Item()
                newItem.title = textField.text!
                
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
    
    // MARK: - Model Manipulatiom Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemsArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}


