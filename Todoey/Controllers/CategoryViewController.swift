//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Богдан Ткачук on 05.03.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    
    let realm = try! Realm()
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadCategories()
    }
    
    //MARK: - TableView Datasourse Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Data Manipulations Methods
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error with saving data \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
//
//        do{
//            categoryArray = try context.fetch(request)
//        }catch{
//            print("Error with loading data \(error)")
//        }
//        tableView.reloadData()
    }
    
    
    //MARK: - Add new Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happends when user clicks into add item button on out UIAlert
            let newCategory = Category()
            newCategory.name = textfield.text!
            
            self.categoryArray.append(newCategory)
    
            self.save(category: newCategory)
        }
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Create new item"
            textfield = alerttextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoeyViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
