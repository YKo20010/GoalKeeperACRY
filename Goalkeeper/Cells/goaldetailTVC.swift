//
//  GoalDetailTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/29/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class goaldetailTVC: UITableViewCell {
    
    var circle: UIImageView = UIImageView()
    var circle2: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    var sublabel: UILabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        circle.layer.cornerRadius = 20/2/267*contentView.frame.width
        circle.layer.masksToBounds = true
        contentView.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circle.topAnchor.constraint(equalTo: contentView.topAnchor),
            circle.heightAnchor.constraint(equalToConstant: 20/267*contentView.frame.width),
            circle.widthAnchor.constraint(equalToConstant: 20/267*contentView.frame.width)
            ])
        
        circle2.translatesAutoresizingMaskIntoConstraints = false
        circle2.backgroundColor = .white
        circle2.layer.cornerRadius = 18/2/267*contentView.frame.width
        circle2.layer.masksToBounds = true
        contentView.addSubview(circle2)
        NSLayoutConstraint.activate([
            circle2.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            circle2.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            circle2.heightAnchor.constraint(equalToConstant: 18/267*contentView.frame.width),
            circle2.widthAnchor.constraint(equalToConstant: 18/267*contentView.frame.width)
            ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16/53*contentView.frame.height, weight: .semibold)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 14/267*contentView.frame.width),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 20/53*contentView.frame.height)
            ])
        
        sublabel.translatesAutoresizingMaskIntoConstraints = false
        sublabel.text = ""
        sublabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        sublabel.font = UIFont.systemFont(ofSize: 12/53*contentView.frame.height, weight: .semibold)
        contentView.addSubview(sublabel)
        NSLayoutConstraint.activate([
            sublabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            sublabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            sublabel.heightAnchor.constraint(equalToConstant: 15/53*contentView.frame.height),
            sublabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2/53*contentView.frame.height)
            ])
    }
    
    func configure(for checkpoint: Checkpoint) {
        label.text = checkpoint.name
        if (checkpoint.isFinished) {
            circle2.backgroundColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "MM/dd/yy"
            sublabel.text = "completed \(dateFormatter.string(from: checkpoint.endDate!))"
        }
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
