//
//  KeyDatesCVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Foundation

class KeyDatesCVC: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    //Labels
    var dateLabel = UILabel()
    var progressSlider = ProgressSlider()
    var tableView: CustomTableView!
    
    var notes: [String] = []
    
    //Shapes
    var circle: UIImageView!
    var line: UIImageView!
    
    let shadowRadius: CGFloat = 8
    let reuseCellIdentifier = "tableViewCellReuseIdentifier"
    
    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.contentView.backgroundColor = .clear
       
        circle = UIImageView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 212/255, green: 114/255, blue: 114/255, alpha: 1.0)
        circle.layer.cornerRadius = (11/414*contentView.frame.width)/2
        circle.layer.masksToBounds = true
        contentView.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18/414*contentView.frame.width),
            circle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18/414*contentView.frame.width),
            circle.widthAnchor.constraint(equalToConstant: 11/414*contentView.frame.width),
            circle.heightAnchor.constraint(equalToConstant: 11/414*contentView.frame.width)
            ])
        
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        contentView.addSubview(line)
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 22/414*contentView.frame.width, weight: .regular)
        dateLabel.textAlignment = .left

        tableView = CustomTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(keydatesTVC.self, forCellReuseIdentifier: reuseCellIdentifier)
        tableView.estimatedRowHeight = 20/414*contentView.frame.width
        tableView.rowHeight = 20/414*contentView.frame.width
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50/414*contentView.frame.width),
            dateLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 28/414*contentView.frame.width),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50/414*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2/414*contentView.frame.width),
            tableView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22/414*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: 10/414*contentView.frame.width),
            line.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: (170 - 151.7)/414*contentView.frame.width),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22/414*contentView.frame.width),
            line.widthAnchor.constraint(equalToConstant: 2/414*contentView.frame.width)
            ])
        
        
    }
    
    /******************************** MARK: UITableView: Data Source ********************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! keydatesTVC
        cell.backgroundColor = .clear
        cell.label.text = notes[indexPath.row]
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}
