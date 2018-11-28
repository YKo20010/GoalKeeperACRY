//
//  GoalDetailCVC.swift
//  Goalkeeper
//
//  Created by Avani Aggrwal on 11/28/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class GoalDetailCVC: UICollectionViewCell {
    let titleLabel = UILabel()
    //var progressSlider = ProgressSlider()
    //var timeLabel = UILabel()
    //var checkpointsLabel = UILabel()
    var arrowLabel = CAShapeLayer()
    let path = UIBezierPath()
    var rec: UIImageView!
    var circle: UIView!
    var line: UIImageView!
    
    let shadowRadius: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //let marginGuide = contentView.layoutMarginsGuide
        
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
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //  checkpointsLabel.text = "checkpoints"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 26/148*contentView.frame.height, weight: .bold)
        
        
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
        
    }
    
    //    func configure(for goal: Goal) {
    //        checkpointsLabel.text = "checkpoints"
    //        motivationLabel.text = "motivation"
    //    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

