//
//  historyTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/30/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class historyTVC: UITableViewCell {
    
    var rec: UIImageView = UIImageView()
    var tab: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    var startDate: UILabel = UILabel()
    var reachedDate: UILabel = UILabel()
    var byDate: UILabel = UILabel()
    
    var netDateFormatter = DateFormatter()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.dateFormat = "MM/dd/yyyy"
        
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = .white
        rec.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        rec.layer.shadowRadius = 8
        rec.layer.masksToBounds = false
        rec.layer.shadowOpacity = 0.5
        rec.layer.shadowOffset = CGSize(width: 6, height: 6)
        rec.clipsToBounds = false
        contentView.addSubview(rec)
        NSLayoutConstraint.activate([
            rec.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42/414*contentView.frame.width),
            rec.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -42/414*contentView.frame.width),
            rec.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20/187*contentView.frame.height),
            rec.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20/187*contentView.frame.width)
            ])
        
        tab.translatesAutoresizingMaskIntoConstraints = false
        //tab.backgroundColor = UIColor(red: 99/255, green: 237/255, blue: 170/255, alpha: 1.0)
        tab.backgroundColor = UIColor.white
        tab.clipsToBounds = true
        tab.layer.masksToBounds = true
        rec.addSubview(tab)
        NSLayoutConstraint.activate([
            tab.trailingAnchor.constraint(equalTo: rec.trailingAnchor),
            tab.widthAnchor.constraint(equalToConstant: 20/330*contentView.frame.width),
            tab.topAnchor.constraint(equalTo: rec.topAnchor),
            tab.bottomAnchor.constraint(equalTo: rec.bottomAnchor)
            ])

        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 26/414*contentView.frame.width, weight: .regular)
        title.textAlignment = .left
        contentView.addSubview(title)
        
        startDate.translatesAutoresizingMaskIntoConstraints = false
        startDate.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        startDate.font = UIFont.systemFont(ofSize: 15/414*contentView.frame.width, weight: .light)
        startDate.textAlignment = .right
        contentView.addSubview(startDate)
        
        byDate.translatesAutoresizingMaskIntoConstraints = false
        byDate.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        byDate.font = UIFont.systemFont(ofSize: 15/414*contentView.frame.width, weight: .light)
        byDate.textAlignment = .right
        contentView.addSubview(byDate)
        
        reachedDate.translatesAutoresizingMaskIntoConstraints = false
        reachedDate.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        reachedDate.font = UIFont.systemFont(ofSize: 15/414*contentView.frame.width, weight: .light)
        reachedDate.textAlignment = .right
        contentView.addSubview(reachedDate)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 20/414*contentView.frame.width),
            title.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -40/414*contentView.frame.width),
            title.heightAnchor.constraint(equalToConstant: 33/414*contentView.frame.width),
            title.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20/187*contentView.frame.height)
            ])
        NSLayoutConstraint.activate([
            startDate.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -40/414*contentView.frame.width),
            startDate.heightAnchor.constraint(equalToConstant: 20/414*contentView.frame.width),
            startDate.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4/187*contentView.frame.height)
            ])
        NSLayoutConstraint.activate([
            byDate.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -40/414*contentView.frame.width),
            byDate.heightAnchor.constraint(equalToConstant: 20/414*contentView.frame.width),
            byDate.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 2/187*contentView.frame.height)
            ])

        NSLayoutConstraint.activate([
            reachedDate.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -40/414*contentView.frame.width),
            reachedDate.heightAnchor.constraint(equalToConstant: 20/414*contentView.frame.width),
            reachedDate.topAnchor.constraint(equalTo: byDate.bottomAnchor, constant: 2/187*contentView.frame.height)
            ])
    }
    
    func configure(for goal: Goal) {
        
        title.text = goal.name
        
        startDate.text = "start: \(goal.startDate)"
        byDate.text = "by: \(goal.date)"
        if goal.endDate != nil {
            reachedDate.text = "reached: \(goal.endDate)"
        }
        else {
            reachedDate.text = ""
        }
        if let dateFromString = netDateFormatter.date(from: goal.endDate) {
            var timeDifference: CGFloat = CGFloat(dateFromString.timeIntervalSince(netDateFormatter.date(from: goal.date)!))
            timeDifference /= (60*60*24)
            if (timeDifference > 90) {
                tab.backgroundColor = UIColor(red: 247/255, green: 136/255, blue: 136/255, alpha: 1.0)
            }
            else if (timeDifference > 60) {
                tab.backgroundColor = UIColor(red: 247/255, green: 187/255, blue: 136/255, alpha: 1.0)
            }
            else if (timeDifference > 30) {
                tab.backgroundColor = UIColor(red: 239/255, green: 196/255, blue: 151/255, alpha: 1.0)
            }
            else if (timeDifference >= 0) {
                tab.backgroundColor = UIColor(red: 229/255, green: 239/255, blue: 151/255, alpha: 1.0)
            }
            else if (timeDifference > -30) {
                tab.backgroundColor = UIColor(red: 186/255, green: 239/255, blue: 151/255, alpha: 1.0)
            }
            else if (timeDifference > -60) {
                tab.backgroundColor = UIColor(red: 151/255, green: 239/255, blue: 168/255, alpha: 1.0)
            }
            else {
                tab.backgroundColor = UIColor(red: 151/255, green: 239/255, blue: 217/255, alpha: 1.0)
            }
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
