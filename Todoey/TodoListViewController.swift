//
//  TodoListViewController.swift
//  Todoey
//
//  Created by ccztr on 2/18/19.
//  Copyright © 2019 Chacer. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Sharon" , "Get Tickets" , "Get Passport" , "Go to Airport" ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selection: " + itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //TODO: Declare tableViewTapped here:
//    @objc func tableViewTapped() {
//
//    }
    
    
    //TODO: Declare configureTableView here:
    
    
    
    ///////////////////////////////////////////

}

