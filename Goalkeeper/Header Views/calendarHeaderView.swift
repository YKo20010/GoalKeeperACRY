//
//  calendarHeaderView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//


import UIKit

class calendarHeaderView: UIView {
    
    var titleLabel: UILabel!

    var co_background: UIColor = UIColor(red: 235/255, green: 195/255, blue: 143/255, alpha: 1.0)
    var co_title: UIColor = .white
    
    var rec: UIImageView!
    
    init(frame: CGRect, textSize: CGFloat, viewHeight: CGFloat) {
        super.init(frame: frame)
        
        self.backgroundColor = co_background
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "calendar"
        titleLabel.textColor = co_title
        titleLabel.font = UIFont.systemFont(ofSize: textSize, weight: .bold)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12/895*viewHeight)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



