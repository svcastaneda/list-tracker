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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let t = task {
            navigationItem.title = t.title
            dueDateLabel.text = t.dueDate.description
            detailsText.text = t.details
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
