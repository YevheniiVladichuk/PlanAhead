//
//  TableViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/05/2023.
//

import UIKit
import RealmSwift

class CategoryController: UITableViewController {
    
    let interface = Interface()
    let realm = try! Realm()
    
    var categories: Results<Category>?
    var searchBar: UISearchBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.categoryCellId)
        
        searchBar = interface.configureSearchbar(for: tableView, withDelegate: self)
        
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Category", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        
        loadCategories()
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
    
    // MARK: - Add New Category
    @objc func addButtonPressed() {
        
        var textField = UITextField()
        let allert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "new", style: .default) {(action) in
            if textField.text != "" {
                
                let newCategory = Category()
                newCategory.categoryName = textField.text!
            
                self.save(category: newCategory)
            }
        }
        allert.addTextField { (allertTexField) in
            allertTexField.placeholder = "New task"
            textField = allertTexField
        }
        
        allert.addAction(action)
        present(allert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        }catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
       
        categories = realm.objects(Category.self)
 
        tableView.reloadData()
    }
    
    // MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellId, for: indexPath)
        
        let categoryTitle = categories?[indexPath.row].categoryName ?? "No Categories Added"
        cell.textLabel?.text = categoryTitle
        cell.backgroundColor = .blue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let category = categories?[indexPath.row] {
                do{
                    try realm.write{
                        realm.delete(category)
                    }
                }catch {
                    print("Error deleting item: \(error)")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("")
        let toDoList = ToDoListController()
        
        toDoList.selectedCategory = categories?[indexPath.row]
        
        toDoList.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(toDoList, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


// MARK: - Extensions
extension CategoryController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        categories = categories?.filter("categoryName CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "categoryName", ascending: true)
        tableView.reloadData()
        
        if searchBar.text!.count == 0 {
            loadCategories()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
