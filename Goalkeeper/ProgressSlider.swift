//
//  ProgressSlider.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/19/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class ProgressSlider: UISlider {

    /*******    Override Default Slider Thickness   *******/
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var bound = super.trackRect(forBounds: bounds)
        bound.size.height = 6
        bound.origin.y -= (bound.size.height)/2
        return bound
    }

}
