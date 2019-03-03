//
//  TodoListViewController.swift
//  Todoey
//
//  Created by ccztr on 2/18/19.
//  Copyright © 2019 Chacer. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Sharon" , "Get Tickets" , "Get Passport" , "Go to Airport" ]
//    let defaults = UserDefaults.standard
    var itemArray = [Item]()
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first.appendPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        
        newItem.title = "Find Sharon"
        itemArray.append(newItem)
//        print(dataFilePath)
//        loadItems()
        
//      UserDefaults version
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    } // end viewDidLoad()

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" , for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selection: " + itemArray[indexPath.row].title)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

// MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks the Add Item button on our UIAlert
            print("Success!Added  " + textField.text!)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.tableView.reloadData()
            
// UserDefaults version
//            self.itemArray.append(textField.text!)
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
//            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    ///////////////////////////////////////////
    //MARK - Model Manupulation Methods

//    func loadItems() {
//        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        tableView.reloadData()
//    }










} // end of class

