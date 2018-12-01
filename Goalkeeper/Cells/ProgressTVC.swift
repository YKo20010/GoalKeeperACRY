//
//  ProgressTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class ProgressTVC: UITableViewCell {

    var progressSlider = ProgressBar()
    var label = UILabel()
    var percent = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.progressTintColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        progressSlider.trackTintColor = UIColor(red: 222/255, green: 236/255, blue: 246/255, alpha: 1.0)
        progressSlider.clipsToBounds = true
        progressSlider.height = 24/350*contentView.frame.width
        progressSlider.layer.cornerRadius = 24/350*contentView.frame.width/2
        
        contentView.addSubview(progressSlider)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26/350*contentView.frame.width, weight: .semibold)
        label.text = "Goal Name"
        contentView.addSubview(label)
        
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        percent.font = UIFont.systemFont(ofSize: 15/350*contentView.frame.width, weight: .medium)
        percent.text = "XX%"
        contentView.addSubview(percent)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progressSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            progressSlider.trailingAnchor.constraint(equalTo: percent.leadingAnchor, constant: -12/350*contentView.frame.width),
            progressSlider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12/71*contentView.frame.height),
            progressSlider.heightAnchor.constraint(equalToConstant: 24/350*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.heightAnchor.constraint(equalToConstant: 33/350*contentView.frame.width),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            percent.heightAnchor.constraint(equalToConstant: 18/350*contentView.frame.width),
            percent.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor)
            ])
    }

    func configure(for goal: Goal) {
        label.text = goal.name
        var numCheck = 0
//        if (goal.checkpoints.count > 1) {
//            for i in 0...goal.checkpoints.count-1 {
//                if (goal.checkpoints[i].isFinished) {
//                    numCheck += 1
//                }
//            }
//        }
//        else if (goal.checkpoints.count != 0 && goal.checkpoints[0].isFinished) {
//            numCheck += 1
//        }
//        if (goal.endDate != nil) {
//            numCheck += 1
//        }
//        if (goal.checkpoints.count != 0) {
//            // count for each checkpoint, plus one for actually completing goal
//            let fraction = numCheck*100/(goal.checkpoints.count + 1)
//            percent.text = "\(fraction)%"
//            progressSlider.setProgress(Float(Double(numCheck)/Double(goal.checkpoints.count + 1)), animated: false)
//        }
//        else if (goal.endDate != nil) {
//            // zero checkpoints, completed goal
//            percent.text = "100%"
//            progressSlider.setProgress(100.0, animated: false)
//        }
//        else {
            // no checkpoints and incomplete goal
            percent.text = "0%"
            progressSlider.setProgress(0.0, animated: false)
        //}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
