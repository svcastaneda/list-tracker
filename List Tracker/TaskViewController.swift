//
//  TaskViewController.swift
//  List Tracker
//
//  Created by David Para on 3/8/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    var task: Task?
    
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var detailsText: UITextView!
    
     var dateFormatter = DateFormatter()
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        detailsText.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "MM/dd/YYYY"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let t = task {
            navigationItem.title = t.title
            let dateString = dateFormatter.string(from: t.dueDate as! Date)
            dueDateLabel.text = "Due:\t\(dateString)"
            detailsText.text = t.details
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        if let detailsEdited = detailsText.text {
            task?.details = detailsEdited
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    */

}
