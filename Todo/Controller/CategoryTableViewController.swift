//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by Taotao Ma on 6/17/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No Category Added yet..."
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    // MARK: - Table View delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.category = categories?[indexPath.row]
        }
        
    }
    
    // MARK: - Data Manipulation Method
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
    }
    
    // MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let category = Category()
            category.name = textField.text!
            
            self.save(category: category)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new category..."
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    

}
