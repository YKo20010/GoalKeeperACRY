//
//  GoalCVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit

class GoalCVC: UICollectionViewCell {

    let titleLabel = UILabel()
    var progressSlider = ProgressSlider()
    var timeLabel = UILabel()
    var checkpointsLabel = UILabel()
    
    let shadowRadius: CGFloat = 8

    var co_recBackground: UIColor = .darkGray
    var co_psMinTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psThumbTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psMaxTrackTint: UIColor = .gray

    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowRadius = shadowRadius
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.75
        contentView.layer.shadowOffset = CGSize(width: 6, height: 6)
        contentView.clipsToBounds = false

        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide

        contentView.addSubview(progressSlider)
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.minimumTrackTintColor = co_psMinTrackTint
        progressSlider.thumbTintColor = co_psThumbTrackTint
        progressSlider.maximumTrackTintColor = co_psMaxTrackTint
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = 100
        progressSlider.value = 0
        progressSlider.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        progressSlider.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        progressSlider.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        progressSlider.setThumbImage(UIImage(), for: .normal)
        progressSlider.isEnabled = false
        progressSlider.isHidden = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 26/110*contentView.frame.height, weight: .bold)
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        timeLabel.font = UIFont.systemFont(ofSize: 16/110*contentView.frame.height, weight: .semibold)
        
        contentView.addSubview(checkpointsLabel)
        checkpointsLabel.translatesAutoresizingMaskIntoConstraints = false
        checkpointsLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        checkpointsLabel.font = UIFont.systemFont(ofSize: 16/110*contentView.frame.height, weight: .semibold)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16/330*contentView.frame.width),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12/110*contentView.frame.height),
            titleLabel.heightAnchor.constraint(equalToConstant: 33/110*contentView.frame.height),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16/330*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5/110*contentView.frame.height),
            timeLabel.heightAnchor.constraint(equalToConstant: 20/110*contentView.frame.height)
            ])
        NSLayoutConstraint.activate([
            checkpointsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            checkpointsLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2/110*contentView.frame.height),
            checkpointsLabel.heightAnchor.constraint(equalToConstant: 20/110*contentView.frame.height)
            ])
    }
    
    func configure(for goal: Goal) {
        titleLabel.text = goal.name
        var diffDate = Calendar.current.dateComponents([.year], from: Date(), to: goal.date).year
        timeLabel.text = diffDate == 1 ? "in \(diffDate!) year" : "in \(diffDate!) years"
        if (diffDate! == 0) {
            diffDate = Calendar.current.dateComponents([.month], from: Date(), to: goal.date).month
            timeLabel.text = diffDate == 1 ? "in \(diffDate!) month" : "in \(diffDate!) months"
        }
        if (diffDate! == 0) {
            diffDate = Calendar.current.dateComponents([.day], from: Date(), to: goal.date).day
            timeLabel.text = diffDate == 1 ? "in \(diffDate!) day" : "in \(diffDate!) days"
        }
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
        checkpointsLabel.text = "\(numCheck)" + "/" + "\(goal.checkpoints.count)" + " checkpoints"
        if (goal.checkpoints.count != 0) {
            progressSlider.value = Float(Double(numCheck)/Double(goal.checkpoints.count)*100.0)
        }
        else {
            progressSlider.value = 100
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
