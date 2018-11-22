//
//  CustomTableView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/21/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }
}
