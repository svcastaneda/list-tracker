//
//  ListViewController.swift
//  List Tracker
//
//  Created by David Para on 2/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import CoreData

var categories: [Category] = []

class ListViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        
        do {
            categories = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Lists"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // Generate the popup that asks the user for new category name
    func addCategory() {
        
        let title = "New List Name"
        let message = ""
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { action in
            if let field = alertController.textFields?[0] {
                if (field.text!.characters.count < 1) {
                    self.invalidInputAlert()
                    return
                }
                // save field
                self.save(title: field.text!)
                self.table.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
            textField.autocapitalizationType = UITextAutocapitalizationType.words
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Remind the user to add a valid category name
    func invalidInputAlert() {
        
        let title = "Missing List Name"
        let message = "Please enter a valid list name. Name must contain at least one letter."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .cancel) { action in
            self.addCategory()
        }
        
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // Enables swipe to delete feature
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    // Removes deleted row from the categories list and deletes the row from the table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let category = categories[indexPath.row]
        
        managedContext.delete(category)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        categories.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = category.value(forKeyPath: "title") as? String
        // Configure the cell...

        return cell
    }
    
    func save(title: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!
        
        let category = Category(entity: entity, insertInto: managedContext)
        
        category.setValue(title, forKeyPath: "title")
        
        categories.append(category)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let tasksTableViewController = segue.destination as? TasksTableViewController
            else { return }
        guard let indexPath = self.tableView.indexPathForSelectedRow
            else { return }
        tasksTableViewController.category = categories[indexPath.row]
        
    }
    

}
