//
//  TabItem.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
class TabItem {
    var image: String
    var name: String
    var selected: Bool
    
    init(image: String, name: String, selected: Bool) {
        self.image = image
        self.name = name
        self.selected = selected
    }
}
