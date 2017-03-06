//
//  Category.swift
//  List Tracker
//
//  Created by David Para on 3/5/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation

var categories: [Category] = [

]

class Category {

    enum Timeframe: String {
        case approchingDeadline = "Due within a week"
        case pastDeadline = "Past Due"
        case inTheClear = ""
    }
    
    var title: String
    var timeframe: Timeframe = .inTheClear
    
    init(title: String, timeframe: Timeframe) {
        self.title = title
    }
    
    func setTimeframe (to timeframe: Timeframe) {
        self.timeframe = timeframe
    }

}
