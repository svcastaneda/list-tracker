//
//  Task.swift
//  List Tracker
//
//  Created by David Para on 3/5/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation

class Task {

    enum Timeframe: String {
        case approchingDeadline = "Due within a week"
        case pastDeadline = "Past Due"
        case inTheClear = ""
    }
    
    var title: String
    var details: String
    var dueDate: Date
    var timeframe: Timeframe = .inTheClear
    
    init(title: String, details: String, dueDate: Date) {
        self.title = title
        self.details = details
        self.dueDate = dueDate
        
        /*
        Implement if-else statements to set timeframe:
        if dueDate is two weeks away
            set timeframe to ""
        else if due date is within one week
            set timeframe to Due within a week
        else 
            alert("Cannot set a task in the past")
        */
    }
    
    func setTimeframe (to timeframe: Timeframe) {
        self.timeframe = timeframe
    }
    
}
