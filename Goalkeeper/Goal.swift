//
//  Goal.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit

class Goal {
    var name: String
    var date: Date
    var checkpoints: [Checkpoint]
    var description: String
    var startDate: Date
    var endDate: Date?
    
    
    init (name: String, date: Date, description: String, checkpoints: [Checkpoint], startDate: Date) {
        self.name = name
        self.date = date
        self.description = description
        self.checkpoints = checkpoints
        self.startDate = startDate
    }
}

//struct Goal: Codable {
//    var name: String
//    var date: Date
//    var checkpoints: [Checkpoint]
//    var description: String
//    var progress: Double
//}
//
//struct GoalsResponse: Codable {
//    var results: [Goal]
//}









