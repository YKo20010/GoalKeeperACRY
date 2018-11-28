//
//  keydatesTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class keydatesTVC: UITableViewCell {
    var label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 115/155, green: 115/155, blue: 115/155, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 16/342*contentView.frame.width, weight: .light)
        label.textAlignment = .left
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
