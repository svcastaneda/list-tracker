//
//  AddNewTaskViewController.swift
//  List Tracker
//
//  Created by David Para on 3/7/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

protocol NewTaskProtocol {
    func setTask(title: String, details: String, dueDate: Date)
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
    @IBOutlet weak var dueDateField: UITextField!
    
    let datePicker = UIDatePicker()
    
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0
        addButton.layer.cornerRadius = 5.0
        cancelButton.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
        
        
        
        createDatePicker()
        addToolbars()
        
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dueDateField.text = formatter.string(from: today)
    }
    
    func addToolbars() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.dateDonePressed))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        dateToolbar.setItems([flexSpace, dateDoneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textView.inputAccessoryView = toolbar
        dueDateField.inputAccessoryView = dateToolbar
        
        dueDateField.inputView = datePicker
    }
    
    func donePressed() {
        self.view.endEditing(true)
    }
    
    func dateDonePressed() {
        let formattedDate = DateFormatter()
        formattedDate.dateStyle = .medium
        formattedDate.timeStyle = .none
        
        dueDateField.text = formattedDate.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        dueDateField.text = "\(datePicker.date)"
    }
    
    // Creates and returns the tasks. Pops view controller on completion
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if textField.text! != "" {
            let title = textField.text
            let details = textView.text
            let dueDate = datePicker.date
            
            delegate?.setTask(title: title!, details: details!, dueDate: dueDate)
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
