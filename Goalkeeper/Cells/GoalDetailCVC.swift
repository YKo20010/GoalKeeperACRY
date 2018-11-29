//
//  GoalDetailCVC.swift
//  Goalkeeper
//
//  Created by Avani Aggrwal on 11/28/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

protocol buttonClicked: class {
    func changedCheckpointStatus(name: String, date: Date, isFinished: Bool, startDate: Date, endDate: Date?)
}

class GoalDetailCVC: UICollectionViewCell, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: ChangeMotivationTitleDelegate?
    weak var delegate2: ChangeCheckpointStatus?
    
    var titleLabel: UILabel!
    var motivationTextView: UITextView!
    var tableView: CustomTableView!

    var rec: UIImageView!
    var circle: UIImageView!
    var line: UIImageView!
    
    var checkpoints: [Checkpoint] = []
    
    var viewHeight: CGFloat = 895
    var viewWidth: CGFloat = 414
    let shadowRadius: CGFloat = 8
    let reuseCellIdentifier = "tableViewCellReuseIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    func setupConstraints() {
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        
        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = .white
        rec.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        rec.layer.shadowRadius = shadowRadius
        rec.layer.cornerRadius = 8
        rec.layer.masksToBounds = false
        rec.layer.shadowOpacity = 0.5
        rec.layer.shadowOffset = CGSize(width: 6, height: 6)
        rec.clipsToBounds = false
        contentView.addSubview(rec)
        
        circle = UIImageView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        circle.layer.cornerRadius = (13/414*viewWidth)/2
        circle.layer.masksToBounds = true
        contentView.addSubview(circle)
        
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        contentView.addSubview(line)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 26/895*viewHeight, weight: .bold)
        contentView.addSubview(titleLabel)
        
        motivationTextView = UITextView()
        motivationTextView.translatesAutoresizingMaskIntoConstraints = false
        motivationTextView.backgroundColor = .clear
        motivationTextView.delegate = self
        motivationTextView.text = "type yourself a reminder of why you want to reach this goal"
        motivationTextView.font = UIFont.systemFont(ofSize: 16/895*viewHeight, weight: .light)
        motivationTextView.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 0.6)
        contentView.addSubview(motivationTextView)
        
        tableView = CustomTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(goaldetailTVC.self, forCellReuseIdentifier: reuseCellIdentifier)
        tableView.estimatedRowHeight = 53/414*viewWidth
        tableView.rowHeight = 53/414*viewWidth
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17/414*viewWidth),
            circle.topAnchor.constraint(equalTo: contentView.topAnchor),
            circle.widthAnchor.constraint(equalToConstant: 13/414*viewWidth),
            circle.heightAnchor.constraint(equalToConstant: 13/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            rec.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            rec.widthAnchor.constraint(equalToConstant: 331/414*viewWidth),
            rec.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32/414*viewWidth),
            rec.topAnchor.constraint(equalTo: contentView.topAnchor)
            ])
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: 10/895*viewHeight),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23/414*viewWidth),
            line.widthAnchor.constraint(equalToConstant: 2/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 18.1/414*viewWidth),
            titleLabel.topAnchor.constraint(equalTo: rec.topAnchor, constant: 16/895*viewHeight),
            titleLabel.heightAnchor.constraint(equalToConstant: 33/895*viewHeight),
            titleLabel.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -18.1/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            motivationTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6/895*viewHeight),
            motivationTextView.heightAnchor.constraint(equalToConstant: 150/895*viewHeight),
            motivationTextView.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 22/414*viewWidth),
            motivationTextView.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -26/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16/895*viewHeight),
            tableView.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 32/414*viewWidth),
            tableView.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -32/414*viewWidth)
            ])
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.changedMotivationText(newTitle: motivationTextView.text)
    }
    
    /******************************** MARK: UITableView: Data Source ********************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkpoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! goaldetailTVC
        cell.backgroundColor = .clear
        let checkpoint = checkpoints[indexPath.row]
        cell.configure(for: checkpoint)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("1")
//        checkpoints[indexPath.row].isFinished = !checkpoints[indexPath.row].isFinished
//        if (checkpoints[indexPath.row].isFinished) {
//            checkpoints[indexPath.row].endDate = Date()
//        }
//        if (!checkpoints[indexPath.row].isFinished) {
//            checkpoints[indexPath.row].endDate = nil
//        }
//        tableView.reloadData()
//        self.delegate2?.changedCheckpointStatus(newCheckpoint: checkpoints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GoalDetailCVC: buttonClicked {
    func changedCheckpointStatus(name: String, date: Date, isFinished: Bool, startDate: Date, endDate: Date?) {
        for i in 0...checkpoints.count-1 {
            if (checkpoints[i].name == name
                && checkpoints[i].date == date
                && checkpoints[i].isFinished == isFinished
                && checkpoints[i].startDate == startDate
                && ((checkpoints[i].endDate == nil && endDate == nil) || (checkpoints[i].endDate != nil && endDate != nil))) {
                    checkpoints[i].isFinished = !checkpoints[i].isFinished
                    if (checkpoints[i].isFinished) {
                        checkpoints[i].endDate = Date()
                    }
                    if (!checkpoints[i].isFinished) {
                        checkpoints[i].endDate = nil
                    }
                    tableView.reloadData()
                    self.delegate2?.changedCheckpointStatus(newCheckpoint: checkpoints)
                return
            }
        }
    }
}

