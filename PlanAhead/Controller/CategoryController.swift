//
//  TableViewController.swift
//  PlanAhead
//
//  Created by Yevhenii Vladichuk on 10/05/2023.
//

import UIKit
import CoreData

class CategoryController: UITableViewController {
    
    let interface = Interface()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoriesArray = [Category]()
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.categoryCellId)
        
        searchBar = interface.configureSearchbar(for: tableView, withDelegate: self)
        
        interface.configNavigationBar(navItem: self.navigationItem, maintTitle: "Category", rBtnTitle: "+", target: self, rBtnAction: #selector(addButtonPressed))
        
        loadCategories()
    }
    
    // MARK: - Add New Category
    @objc func addButtonPressed() {
        
        var textField = UITextField()
        let allert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "new", style: .default) {(action) in
            if textField.text != "" {
                
                let newCategory = Category(context: self.context)
                newCategory.categoryName = textField.text!
                
                self.categoriesArray.append(newCategory)
                self.saveCategory()
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
    func saveCategory() {
        do {
            try context.save()
        }catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print("Error fetching request: \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellId, for: indexPath)
        
        let categoryTitle = categoriesArray[indexPath.row].categoryName
        cell.textLabel?.text = categoryTitle
        cell.backgroundColor = .blue
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("")
        let toDoList = ToDoListController()
        
        toDoList.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(toDoList, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


// MARK: - Extensions
extension CategoryController: UISearchBarDelegate {
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
}
