//
//  subHeader.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class subHeader: UIView {

    var titleLabel: UILabel!
    
    var co_background: UIColor = UIColor(red: 235/255, green: 195/255, blue: 143/255, alpha: 1.0)
    var co_title: UIColor = .white
    
    var rec: UIImageView!
    
    init(frame: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) {
        super.init(frame: frame)
        
        self.backgroundColor = co_background
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "key dates"
        titleLabel.textColor = co_title
        titleLabel.font = UIFont.systemFont(ofSize: 26/895*viewHeight, weight: .bold)
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 36.1/414*viewWidth),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




