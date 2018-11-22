//
//  DateTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/21/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class DateTVC: UITableViewCell {

    let dateLabel = UILabel()
    let date = UILabel()
    
    var co_background: UIColor = .clear
    var co_text: UIColor = .black

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = co_background
        
        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        dateLabel.numberOfLines = 0 // make label multi-line
        dateLabel.textColor = co_text
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dateLabel.text = "Finish By: "
        
        contentView.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        date.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        date.numberOfLines = 0 // make label multi-line
        date.textColor = co_text
        date.font = UIFont.systemFont(ofSize: 16, weight: .light)
        date.text = "Date"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
