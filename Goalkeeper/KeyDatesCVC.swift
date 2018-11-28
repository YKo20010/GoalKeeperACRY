//
//  KeyDatesCVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/27/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class KeyDatesCVC: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    //Labels
    var dateLabel = UILabel()
    var progressSlider = ProgressSlider()
    var tableView: CustomTableView!
    
    var notes: [String] = []
    
    //Shapes
    var circle: UIView!
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
        //self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 11/414*contentView.frame.width, height: 11/414*contentView.frame.width))
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 212/255, green: 114/255, blue: 114/255, alpha: 1.0)
        circle.layer.cornerRadius = (11/414*contentView.frame.width)/2
        circle.center = CGPoint(x: 18/414*contentView.frame.width + 11/2/414*contentView.frame.width, y: 18/414*contentView.frame.width + 11/2/414*contentView.frame.width)
        contentView.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18/414*contentView.frame.width),
            circle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18/414*contentView.frame.width)
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.isScrollEnabled = false
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
    
//    /***************************    MARK: CONFIGURE CELL  **************************/
//    func configure(for goal: Goal) {
//        dateLabel.text = goal.name
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}
