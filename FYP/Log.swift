//
//  Log.swift
//  FYP
//
//  Created by Sandeep Walia on 10/02/2018.
//  Copyright © 2018 Sandeep Walia. All rights reserved.
//

import Foundation

class Log {
    
    var date: String
    var mood: String
    var sleep: Int
    var alcohol: Int
    var work: Int
    var medication: Bool
    
    init(date: String, mood: String, sleep: Int, alcohol: Int, work: Int, medication: Bool) {
        self.date = date
        self.mood = mood
        self.sleep = sleep
        self.alcohol = alcohol
        self.work = work
        self.medication = medication
    }
}
