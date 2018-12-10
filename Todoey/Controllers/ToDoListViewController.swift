//
//  ViewController.swift
//  Todoey
//
//  Created by Onur İpekboyayan on 3.12.2018.
//  Copyright © 2018 Onur İpekboyayan. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController : UITableViewController {

    var toDoItems : Results<Item>?
    
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // hata verdi : searchBar.delegate = self --main.storyboard'da delegate atadım
        
        
        //loadItems()
        
        
  //      if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
  //         itemArray = items
  //      }
            
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK -- TABLEVIEW DATASOURCE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "no items added"
        }
    
        return cell
    }

      //MARK -- TABLEVIEW DELEGTE METHODS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
        do {
            try realm.write {
            item.done = !item.done
            }
        } catch {
            print("error saving done status, \(error)")
        }
        }
        
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
        
        //print(itemArray[indexPath.row])
   
  //      context.delete(itemArray[indexPath.row])
  //      toDoItems.remove(at: indexPath.row)

    //    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      
  //      toDoItems?[indexPath.row].done = !toDoItems[indexPath.row].done
        
  //       saveItems()
        

    
    //MARK -- ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks add item button on our UIAlert
            print("success!")
            
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                } catch {
                    print("error saving new items, \(error)")
            }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
//MARK -- Model manipulation methods
    

    
    func loadItems() {
        
   toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            tableView.reloadData()
       }
    

}
//MARK - searchbar methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
