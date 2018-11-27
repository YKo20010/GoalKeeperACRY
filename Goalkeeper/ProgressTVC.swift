//
//  ProgressTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class ProgressTVC: UITableViewCell {

    var progressSlider = ProgressSlider()
    var label = UILabel()
    var percent = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.minimumTrackTintColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        progressSlider.thumbTintColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        progressSlider.maximumTrackTintColor = UIColor(red: 222/255, green: 236/255, blue: 246/255, alpha: 1.0)
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = 100
        progressSlider.value = 0
        progressSlider.setThumbImage(UIImage(), for: .normal)
        progressSlider.isEnabled = false
        progressSlider.clipsToBounds = true
        progressSlider.height = 30/71*contentView.frame.height
        contentView.addSubview(progressSlider)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30/71*contentView.frame.height, weight: .semibold)
        label.text = "Goal Name"
        contentView.addSubview(label)
        
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        percent.font = UIFont.systemFont(ofSize: 24/71*contentView.frame.height, weight: .medium)
        percent.text = "XX%"
        contentView.addSubview(percent)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progressSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            progressSlider.widthAnchor.constraint(equalToConstant: 295/350*contentView.frame.width),
            progressSlider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12/71*contentView.frame.height)
            ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.heightAnchor.constraint(equalToConstant: 37/71*contentView.frame.height),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            percent.heightAnchor.constraint(equalToConstant: 27/71*contentView.frame.height),
            percent.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor)
            ])
    }

    func configure(for goal: Goal) {
        label.text = goal.name
        var numCheck = 0
        if (goal.checkpoints.count > 1) {
            for i in 0...goal.checkpoints.count-1 {
                if (goal.checkpoints[i].isFinished) {
                    numCheck += 1
                }
            }
        }
        else if (goal.checkpoints.count != 0 && goal.checkpoints[0].isFinished) {
            numCheck += 1
        }
        if (goal.checkpoints.count != 0) {
            let fraction = numCheck*100/goal.checkpoints.count
            percent.text = "\(fraction)%"
            progressSlider.value = Float(Double(numCheck)/Double(goal.checkpoints.count)*100.0)
        }
        else {
            percent.text = "100%"
            progressSlider.value = 100
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
