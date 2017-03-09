//
//  TasksTableViewController.swift
//  List Tracker
//
//  Created by David Para on 3/5/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController, NewTaskProtocol {
    
    @IBOutlet var table: UITableView!
    
    var category: Category?
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // Generate the popup that asks the user for new category name
    func addTask() {
        let newTaskViewController = storyboard!.instantiateViewController(withIdentifier: "Add New Task") as! AddNewTaskViewController
        newTaskViewController.delegate = self
        self.navigationController?.pushViewController(newTaskViewController, animated: true)
    }
    
    // Enables swipe to delete feature
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    // Removes deleted row from the categories list and deletes the row from the table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        category?.tasks.remove(at: indexPath.row)
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
        
        var count = 0
        if !(category?.tasks.isEmpty)! {
            count = (category?.tasks.count)!
        }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = category?.tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = task?.title
        // Configure the cell...

        return cell
    }
    
    func setTask(to task: Task) {
        self.category?.tasks.insert(task, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.table.insertRows(at: [indexPath], with: .automatic)
        
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
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
