//
//  TodoListViewController.swift
//  Todoey
//
//  Created by ccztr on 2/18/19.
//  Copyright © 2019 Chacer. All rights reserved.
//  Updated 5/09/2019
// 

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
 
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var cellColor : String = ""
    var selectedCategory : Category? {
        didSet {
            navigationItem.title = selectedCategory?.name
            loadItems()
        }
    }
    override func viewDidLoad() { 
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
 
//    override func viewWillAppear(_ animated: Bool) {
//
//        title = selectedCategory?.name
//
//        guard let colorHex = selectedCategory?.color else { fatalError() }
//
//        updateNavBar(withHexCode: colorHex)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//        updateNavBar(withHexCode: "1D9BF6")
//
//    }
    
    //MARK: - Nav Bar Setup Methods
    
//    func updateNavBar(withHexCode colourHexCode: String){
//
//        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
//
//        guard let navBarColor = UIColor(hexString: colourHexCode) else { fatalError()}
//
//        navBar.barTintColor = navBarColor
//
//        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
//
//        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
//
//        searchBar.barTintColor = navBarColor
//
//    }
    
    
    //MARK: - TableView DataSource Methods
    
   // Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1            //  <=======<<< Nil Coalescing Operator
    }
    
    // Declare cellForRowAtIndexPath here:
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
           
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
                    cell.backgroundColor = color
                    cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                }
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
                    cell.textLabel?.text = "No Items Added Yet"
                }
        return cell
    }

    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
// MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items \(error)")
                }
            }
            self.tableView.reloadData()
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    } // END addButtonPressed()
    
    
//MARK - Model Manupulation Methods
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title" , ascending: true)
        self.tableView.reloadData()
    }

    override func updateModel(at indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                    print("ItemView Item deleted from superclass")
                }
            } catch {
                print("Error deleting Item, \(error)")
            }
        }
    }

} // ////////// end of class //////////////

//MARK- Extensions
// search bar methods

extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // sorted on title
       // todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
       
        // sorted on dateCreated
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
    }

    // clear search results and display full item list
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
    }
} // end search bar extension





























