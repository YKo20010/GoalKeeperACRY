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
    var arrowLabel = CAShapeLayer()
    let path = UIBezierPath()
    var rec: UIImageView!
    var circle: UIView!
    var line: UIImageView!
    
    let shadowRadius: CGFloat = 8

    var co_recBackground: UIColor = .white
    var co_psMinTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psThumbTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psMaxTrackTint: UIColor = .gray

    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear

        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide

        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = .white
        rec.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        rec.layer.shadowRadius = shadowRadius
        rec.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        rec.layer.masksToBounds = false
        rec.layer.shadowOpacity = 0.5
        rec.layer.shadowOffset = CGSize(width: 6, height: 6)
        contentView.clipsToBounds = false
        rec.clipsToBounds = false
        contentView.addSubview(rec)
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 13/364*contentView.frame.width, height: 13/364*contentView.frame.width))
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor(red: 201/255, green: 142/255, blue: 25/255, alpha: 1.0)
        circle.layer.cornerRadius = (13/364*contentView.frame.width)/2
        circle.center = CGPoint(x: 13/2/364*contentView.frame.width, y: 13/2/148*contentView.frame.height)
        contentView.addSubview(circle)
        
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        contentView.addSubview(line)

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
        titleLabel.font = UIFont.systemFont(ofSize: 26/148*contentView.frame.height, weight: .bold)
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        timeLabel.font = UIFont.systemFont(ofSize: 16/148*contentView.frame.height, weight: .semibold)
        
        contentView.addSubview(checkpointsLabel)
        checkpointsLabel.translatesAutoresizingMaskIntoConstraints = false
        checkpointsLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        checkpointsLabel.font = UIFont.systemFont(ofSize: 16/148*contentView.frame.height, weight: .semibold)
        
        path.move(to: CGPoint(x: 348/364*contentView.frame.width, y: 54.4/148*contentView.frame.height))
        path.addLine(to: CGPoint(x: 339/364*contentView.frame.width, y: 63.7/148*contentView.frame.height))
        path.move(to: CGPoint(x: 348/364*contentView.frame.width, y: 54.4/148*contentView.frame.height))
        path.addLine(to: CGPoint(x: 339/364*contentView.frame.width, y: 45/148*contentView.frame.height))
        path.close()
        
        arrowLabel.strokeColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0).cgColor
        arrowLabel.path = path.cgPath
        arrowLabel.lineCap = kCALineCapSquare
        arrowLabel.lineWidth = 2/148*contentView.frame.height
        arrowLabel.lineJoin = kCALineJoinRound
        contentView.layer.addSublayer(arrowLabel)
        
        NSLayoutConstraint.activate([
            rec.heightAnchor.constraint(equalToConstant: 110/148*contentView.frame.height),
            rec.widthAnchor.constraint(equalToConstant: 330/364*contentView.frame.width),
            rec.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 17/364*contentView.frame.width),
            rec.topAnchor.constraint(equalTo: contentView.topAnchor)
            ])
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23/148*contentView.frame.height),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6/364*contentView.frame.width),
            line.widthAnchor.constraint(equalToConstant: 2/364*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: rec.leadingAnchor, constant: 16/364*contentView.frame.width),
            titleLabel.topAnchor.constraint(equalTo: rec.topAnchor, constant: 12/148*contentView.frame.height),
            titleLabel.heightAnchor.constraint(equalToConstant: 33/148*contentView.frame.height),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16/364*contentView.frame.width)
            ])
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5/148*contentView.frame.height),
            timeLabel.heightAnchor.constraint(equalToConstant: 20/148*contentView.frame.height)
            ])
        NSLayoutConstraint.activate([
            checkpointsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            checkpointsLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2/148*contentView.frame.height),
            checkpointsLabel.heightAnchor.constraint(equalToConstant: 20/148*contentView.frame.height)
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
