//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Onur İpekboyayan on 7.12.2018.
//  Copyright © 2018 Onur İpekboyayan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    
    override func viewDidLoad() {
    super.viewDidLoad()

    loadCategories()
        
    }
    
    
    //MARK - TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    //Ternary operator ==>
    // value = condition ? value if true : value if false
    
    
    // if item.done == true {
    //     cell.accessoryType = .checkmark
    // } else {
    //     cell.accessoryType = .none
    // }
    
    
}
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    
    
    
    
    //MARK - DATA MANIPULATION METHODS
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK - ADD NEW CATEGORIES
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks add item button on our UIAlert
            print("success!")
            
            let newCategory = Category(context: self.context)
            
            
            newCategory.name = textField.text!
           
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    

    
    
    

    
}
