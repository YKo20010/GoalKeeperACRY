//
//  HeaderView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/25/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var colorView: UIView!
    var titleLabel: UILabel!
    
    var co_colorView: UIColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
    var co_background: UIColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
    var co_title: UIColor = .white
    
    var rec: UIImageView!
    
    init(frame: CGRect, textSize: CGFloat) {
        super.init(frame: frame)
        
        self.backgroundColor = co_background
        
        self.layer.shadowColor = UIColor(red: 198/255, green: 181/255, blue: 181/255, alpha: 1.0).cgColor
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.clipsToBounds = false
        
        colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = co_colorView
        self.addSubview(colorView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "my goals"
        titleLabel.textColor = co_title
        titleLabel.font = UIFont.systemFont(ofSize: textSize, weight: .bold)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



