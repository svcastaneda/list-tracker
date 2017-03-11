//
//  AddNewTaskViewController.swift
//  List Tracker
//
//  Created by David Para on 3/7/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

protocol NewTaskProtocol {
    func setTask(to task: Task)
}



class AddNewTaskViewController: UIViewController {
    
    var date: Date?
    var task: Task?
    var delegate: NewTaskProtocol?

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dueDateLabel: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        dateFormatter.dateFormat = "MM/dd/YYYY"
        // Do any additional setup after loading the view.
    }

    @IBAction func editEnded(_ sender: UITextField) {
        textField.resignFirstResponder()
    }
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        textField.resignFirstResponder()
        textView.resignFirstResponder()
        datePicker.resignFirstResponder()
        datePicker.isHidden = true
    }
    
    @IBAction func dueDatePressed(_ sender: UIButton) {
        datePicker.isHidden = false
    }
    
    @IBAction func datePickerChange(sender: UIDatePicker) {
        let buttonTitle = dateFormatter.string(from: sender.date)
        dueDateLabel.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func selectionEnded(_ sender: UIDatePicker) {
        datePicker.isHidden = true
    }
    
    // Creates and returns the tasks. Pops view controller on completion
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if textField.text! != "" {
            let title = textField.text
            let details = textView.text
            task = Task(title: title!, details: details!, dueDate: datePicker.date)
            delegate?.setTask(to: task!)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // Complete
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            
    }
    */

}
