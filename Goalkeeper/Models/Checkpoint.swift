//
//  Checkpoint.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/21/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit

//class Checkpoint {
//    var name: String
//    var date: Date
//    var isFinished: Bool
//    var startDate: Date
//    var endDate: Date?
//
//    init (name: String, date: Date, isFinished: Bool, startDate: Date) {
//        self.name = name
//        self.date = date
//        self.isFinished = isFinished
//        self.startDate = startDate
//    }
//}

struct Checkpoint: Codable {
    let id: Int
    var name: String
    var date: String
    var isFinshed: Bool
    var startDate: String
    var endDate: String
}

struct CheckpointsResponse: Codable {
    var data: [Checkpoint]
}






