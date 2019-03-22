//
//  TodoListViewController.swift
//  Todoey
//
//  Created by ccztr on 2/18/19.
//  Copyright © 2019 Chacer. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

//    var itemArray = ["Find Sharon" , "Get Tickets" , "Get Passport" , "Go to Airport" ]
//    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first.appendPathComponent("Items.plist")
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
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
        //print("Selection: " + itemArray[indexPath.row].title)
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        // CRUD - Update
       //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // itemArray[indexPath.row].setValue("Completed", forKey: "title" )
        
        // CRUD - Delete
        self.context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }

// MARK - Add New Items CRUD - Create
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks the Add Item button on our UIAlert
            // print("Success!Added  " + textField.text!)
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
            

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

    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context ==> \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    
    // CRUD - Read
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
        try itemArray = context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }










} // end of class

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Boneyard
// UserDefaults version
//            self.itemArray.append(textField.text!)
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
//            self.tableView.reloadData()
