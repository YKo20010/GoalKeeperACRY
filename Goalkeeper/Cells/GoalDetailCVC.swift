//
//  GoalDetailCVC.swift
//  Goalkeeper
//
//  Created by Avani Aggrwal on 11/28/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

protocol buttonClicked: class {
    func changedCheckpointStatus(id: Int, name: String, date: String, isFinished: Bool, startDate: String, endDate: String)
}
protocol changeMotivation: class {
    func changedMotivation(newText: String)
}

class GoalDetailCVC: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate2: ChangeCheckpointStatus?
    
    var titleLabel: UILabel!
    var motivationTextView: UITextView!
    var tableView: CustomTableView!
    var addCheckpointButton: UIButton!

    var rec: UIImageView!
    var circle: UIImageView!
    var line: UIImageView!
    
    var c: [Checkpoint] = []
    
    var viewHeight: CGFloat = 0
    var viewWidth: CGFloat = 0
    let shadowRadius: CGFloat = 8
    let reuseCellIdentifier = "tableViewCellReuseIdentifier"
    
    var netDateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.timeZone = .current
        netDateFormatter.dateFormat = "MM/dd/yyyy"
       
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        contentView.addSubview(line)
        
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
        
        motivationTextView = UITextView()
        motivationTextView.translatesAutoresizingMaskIntoConstraints = false
        motivationTextView.backgroundColor = .clear
        motivationTextView.text = "type yourself a reminder of why you want to reach this goal"
        motivationTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        motivationTextView.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 0.6)
        motivationTextView.showsVerticalScrollIndicator = false
        motivationTextView.isEditable = false
        contentView.addSubview(motivationTextView)
        
        addCheckpointButton = UIButton()
        addCheckpointButton.translatesAutoresizingMaskIntoConstraints = false
        addCheckpointButton.setImage(UIImage(named: "addCheckpointButton"), for: .normal)
        addCheckpointButton.backgroundColor = .clear
        addCheckpointButton.contentMode = .scaleAspectFit
        addCheckpointButton.addTarget(self, action: #selector(addCheckpoint), for: .touchDown)
        contentView.addSubview(addCheckpointButton)
    }
    
    @objc func addCheckpoint() {
        tableView.removeFromSuperview()
        self.delegate2?.beginAddCheckpoint()
    }
    
    func setupConstraints() {
        
        circle = UIImageView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        circle.layer.cornerRadius = (13/414*viewWidth)/2
        circle.layer.masksToBounds = true
        contentView.addSubview(circle)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .white
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 26/895*viewHeight, weight: .bold)
        contentView.addSubview(titleLabel)
        
        tableView = CustomTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(goaldetailTVC.self, forCellReuseIdentifier: reuseCellIdentifier)
        tableView.estimatedRowHeight = 53
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
            rec.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -51/895*viewHeight),
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
            titleLabel.trailingAnchor.constraint(equalTo: addCheckpointButton.leadingAnchor, constant: -18/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            motivationTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6/895*viewHeight),
            motivationTextView.bottomAnchor.constraint(equalTo: rec.bottomAnchor, constant: -23/895*viewHeight),
            motivationTextView.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 22/414*viewWidth),
            motivationTextView.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -26/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16/895*viewHeight),
            tableView.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 32/414*viewWidth),
            tableView.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -32/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            addCheckpointButton.topAnchor.constraint(equalTo: rec.topAnchor, constant: 22/895*viewHeight),
            addCheckpointButton.trailingAnchor.constraint(equalTo: rec.trailingAnchor, constant: -18/414*viewWidth),
            addCheckpointButton.widthAnchor.constraint(equalToConstant: 20/414*viewWidth),
            addCheckpointButton.heightAnchor.constraint(equalToConstant: 20/414*viewWidth)
            ])
    }
    
    /******************************** MARK: UITableView: Data Source ********************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53/895*viewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! goaldetailTVC
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        let checkpoint = c[indexPath.row]
        cell.configure(for: checkpoint)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            c.remove(at: indexPath.row)
            titleLabel.removeFromSuperview()
            tableView.removeFromSuperview()
            self.delegate2?.changedCheckpointStatus(nc: c)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GoalDetailCVC: buttonClicked {
    func changedCheckpointStatus(id: Int, name: String, date: String, isFinished: Bool, startDate: String, endDate: String) {
        if (c.count > 1) {
            for i in 0...c.count-1 {
                if (c[i].id == id) {
                        c[i].isFinished = !c[i].isFinished
                        if (c[i].isFinished) {
                            c[i].endDate = netDateFormatter.string(from: Date())
                        }
                        if (!c[i].isFinished) {
                            c[i].endDate = ""
                        }
            }}
        }
        else if (c[0].id == id) {
                c[0].isFinished = !c[0].isFinished
                if (c[0].isFinished) {
                    c[0].endDate = netDateFormatter.string(from: Date())
                }
                if (!c[0].isFinished) {
                    c[0].endDate = ""
                }
        }
        titleLabel.removeFromSuperview()
        tableView.removeFromSuperview()
        self.delegate2?.changedCheckpointStatus(nc: c)
    }
}

extension GoalDetailCVC: changeMotivation {
    func changedMotivation(newText: String) {
        motivationTextView.text = newText
    }
}


