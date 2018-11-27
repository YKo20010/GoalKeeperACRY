//
//  ProgressSlider.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/19/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class ProgressSlider: UISlider {
    
    var height: CGFloat = 26
    
    /*******    Override Default Slider Thickness   *******/
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var bound = super.trackRect(forBounds: bounds)
        bound.size.height = height
        bound.origin.y -= height/2
        return bound
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = height/2
        self.clipsToBounds = true
        self.heightAnchor.constraint(equalToConstant: height)
        //self.layer.sublayers![1].cornerRadius = height/2
        //self.subviews[1].clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
