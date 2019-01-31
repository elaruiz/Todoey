//
//  ViewController.swift
//  Todoey
//
//  Created by Apok Developer on 1/29/19.
//  Copyright © 2019 Apok Developer. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemCollection : [Item] = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }

    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemCollection[indexPath.row]
        cell.textLabel?.text = item.title
       
        toggleCellCheckbox(cell, isCompleted: item.done)
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(itemArray[indexPath.row])
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        itemCollection[indexPath.row].done = !itemCollection[indexPath.row].done
        
        toggleCellCheckbox(cell, isCompleted: itemCollection[indexPath.row].done)
        
        saveData()

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // what will happen once the user clicks the add item button on our UIAlert
          //  guard let textField = alert.textFields?.first, let text = textField.text else { return }
            guard let text = textField.text else { return }
            let todo = Item(title: text)
            
            self.itemCollection.append(todo)
            
            self.saveData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Toggle Done Property
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    func saveData() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemCollection)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemCollection = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding")
            }
        }
    }
}

