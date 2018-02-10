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
    
    init(date: String, mood: String, sleep: Int) {
        self.date = date
        self.mood = mood
        self.sleep = sleep
    }
}
