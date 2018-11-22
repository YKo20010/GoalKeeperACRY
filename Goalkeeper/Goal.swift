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
    var progress: Double
    
    
    init (name: String, date: Date, description: String, checkpoints: [Checkpoint], progress: Double) {
        self.name = name
        self.date = date
        self.description = description
        self.checkpoints = checkpoints
        self.progress = progress
    }
}

/*
 Purpose: Set Goals and keep track of the timeline
 
 APIs:
 Google calendar
 
 Features:
 Button to create goals: takes user to new page
 Add goals to a list
 Set deadlines
 Set checkpoints
 w/ “mini-goals” attached to them, e.g. pushups?
 Incentive (similar to watering a plant when progress made)
 Notifications: Set when to remind user
 
 Screens:
 Home screen
 Set Goal screen
 Goal Progress screen
 UI Tab Bar at bottom w/ collection: Others’ goals, add goals, User’s goals
 
 Kevin’s Suggestions
 
 MAKE AN APP THAT WORKS!!!
 
 Must-Have: Add goals, add description, date you want to finish by
 
 Additional Features: Checkpoints, Progress bar, Multiple users (sign-in feature: username/password), Onboarding
 
 Sketch alternative: zeplin.io
 
 Timeline:
 Design: ASAP
 IOS: After Thanksgiving - Finish most UI components
 Backend: Get/Add/Edit/Delete Goals
 */

