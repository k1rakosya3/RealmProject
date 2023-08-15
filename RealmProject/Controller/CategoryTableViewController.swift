//
//  CategoryTableViewController.swift
//  Alert
//
//  Created by Admin on 04.08.23.
//

import UIKit
import RealmSwift
import SwipeCellKit


class CategoryTableViewController: SwipeTableViewController {
    
    var realm = try! Realm()
    var categorys: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    
    // MARK: Actions
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var text = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
        let newCatgory = Category()
        newCatgory.name = text.text ?? ""
            
        self.save(kategory: newCatgory)
            
        }
        alert.addAction(alertAction)
        
        alert.addTextField { alertText in
        text = alertText
        text.placeholder = "Add new category"
        }
        
        present(alert, animated: true)
    }
    
    //MARK: Function
    func save(kategory: Category) {
        do {
            try realm.write {
                realm.add(kategory)
            }
        } catch {
            print("error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        categorys = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categorys?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
                
            } catch {
                print("error")
            }
        }
    }
    
    
    //MARK: Delegates methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categorys?[indexPath.row]
        }
    }
    
    //MARK: DataSourse method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return categorys?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categorys?[indexPath.row].name ?? "Not add property"
        return cell
    }
    
}

