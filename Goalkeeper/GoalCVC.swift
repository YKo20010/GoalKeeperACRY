//
//  GoalTVC.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit

class GoalCVC: UICollectionViewCell {

    let titleLabel = UILabel()
    let detailLabel = UILabel()
    var rec: UIImageView!
    var progressSlider = ProgressSlider()

    var co_recBackground: UIColor = .darkGray
    var co_psMinTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psThumbTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psMaxTrackTint: UIColor = .gray

    // MARK: Initalizers
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide

        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = co_recBackground
        rec.layer.masksToBounds = true
        rec.layer.cornerRadius = 5
        contentView.addSubview(rec)

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0 // make label multi-line
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = false
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0 // make label multi-line
        detailLabel.textColor = .white
        detailLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        detailLabel.isHidden = true

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

        NSLayoutConstraint.activate([
            rec.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            rec.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            rec.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rec.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
            ])
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
