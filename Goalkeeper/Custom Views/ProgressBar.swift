//
//  ProgressBar.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class ProgressBar: UIProgressView {
    var height: CGFloat = 22
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
        
        subviews.forEach { subview in
            subview.layer.masksToBounds = true
            subview.layer.cornerRadius = height / 2.0
        }
        
    }


}
