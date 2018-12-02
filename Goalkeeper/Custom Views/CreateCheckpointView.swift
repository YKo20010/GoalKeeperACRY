//
//  CreateCheckpointView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/30/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class CreateCheckpointView: UIView {
    
    weak var delegate: createCheckpoint?
    
    var goalID: Int = -1
    
    var d_name: UITextField = UITextField()
    var d_dateLabel: UILabel = UILabel()
    
    var date: Date = Date(timeIntervalSinceNow: 60*60*24)
    let dateFormatter = DateFormatter()
    var d_datePicker: UIDatePicker!
    
    var n_yesButton: UIButton!
    var n_noButton: UIButton!
    var rec: UIImageView!
    
    var netDateFormatter = DateFormatter()
    
    init(frame: CGRect, viewHeight: CGFloat, viewWidth: CGFloat) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.timeZone = .current
        netDateFormatter.dateFormat = "MM/dd/yyyy"
        
        d_name.translatesAutoresizingMaskIntoConstraints = false
        d_name.backgroundColor = .clear
        d_name.textColor = .white
        d_name.text = "New Checkpoint"
        d_name.textAlignment = .center
        d_name.borderStyle = .none
        d_name.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .regular)
        d_name.placeholder = "Enter Checkpoint Name"
        d_name.clearsOnBeginEditing = true
        self.addSubview(d_name)
        NSLayoutConstraint.activate([
            d_name.topAnchor.constraint(equalTo: self.topAnchor, constant: 40/895*viewHeight),
            d_name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20/414*viewWidth),
            d_name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20/414*viewWidth)
            ])
        
        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = .white
        self.addSubview(rec)
        NSLayoutConstraint.activate([
            rec.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20/414*viewWidth),
            rec.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20/414*viewWidth),
            rec.topAnchor.constraint(equalTo: d_name.bottomAnchor, constant: 10/895*viewHeight),
            rec.heightAnchor.constraint(equalToConstant: 2)
            ])
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        d_dateLabel.translatesAutoresizingMaskIntoConstraints = false
        d_dateLabel.textColor = UIColor.white
        d_dateLabel.text = "\(dateFormatter.string(from: date))"
        d_dateLabel.font = UIFont.systemFont(ofSize: 16/895*viewHeight, weight: .light)
        d_dateLabel.textAlignment = .left
        self.addSubview(d_dateLabel)
        NSLayoutConstraint.activate([
            d_dateLabel.topAnchor.constraint(equalTo: rec.bottomAnchor, constant: 10/895*viewHeight),
            d_dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        
        n_yesButton = UIButton()
        n_yesButton.translatesAutoresizingMaskIntoConstraints = false
        n_yesButton.backgroundColor = UIColor.clear
        n_yesButton.setTitleColor(UIColor.white, for: .normal)
        n_yesButton.layer.cornerRadius = 8
        n_yesButton.layer.masksToBounds = true
        n_yesButton.addTarget(self, action:#selector(save(sender:)), for: .touchDown)
        n_yesButton.setTitle("Save", for: .normal)
        n_yesButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        n_yesButton.titleLabel?.textAlignment = .center
        n_yesButton.layer.borderColor = UIColor.white.cgColor
        n_yesButton.layer.borderWidth = 1
        self.addSubview(n_yesButton)
        NSLayoutConstraint.activate([
            n_yesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25/895*viewHeight),
            n_yesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25/895*viewHeight),
            n_yesButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            n_yesButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 25/895/2*viewHeight)
            ])
        
        n_noButton = UIButton()
        n_noButton.translatesAutoresizingMaskIntoConstraints = false
        n_noButton.backgroundColor = UIColor.clear
        n_noButton.setTitleColor(UIColor.white, for: .normal)
        n_noButton.layer.cornerRadius = 8
        n_noButton.layer.masksToBounds = true
        n_noButton.addTarget(self, action:#selector(cancel(sender:)), for: .touchDown)
        n_noButton.setTitle("Cancel", for: .normal)
        n_noButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        n_noButton.titleLabel?.textAlignment = .center
        n_noButton.layer.borderColor = UIColor.white.cgColor
        n_noButton.layer.borderWidth = 1
        self.addSubview(n_noButton)
        NSLayoutConstraint.activate([
            n_noButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25/895*viewHeight),
            n_noButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25/895*viewHeight),
            n_noButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            n_noButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -25/895/2*viewHeight)
            ])
        
        d_datePicker = UIDatePicker()
        d_datePicker.translatesAutoresizingMaskIntoConstraints = false
        d_datePicker.minimumDate = Date()
        d_datePicker.maximumDate = Date(timeIntervalSinceNow: 60*60*24*365*5)
        d_datePicker.datePickerMode = .date
        d_datePicker.setValue(UIColor.white, forKey: "textColor")
        d_datePicker.backgroundColor = .clear
        d_datePicker.layer.cornerRadius = 5
        d_datePicker.layer.masksToBounds = true
        d_datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        self.addSubview(d_datePicker)
        NSLayoutConstraint.activate([
            d_datePicker.topAnchor.constraint(equalTo: d_dateLabel.bottomAnchor, constant: 20/895*viewHeight),
            d_datePicker.leadingAnchor.constraint(equalTo: rec.leadingAnchor),
            d_datePicker.trailingAnchor.constraint(equalTo: rec.trailingAnchor),
            d_datePicker.bottomAnchor.constraint(equalTo: n_noButton.topAnchor, constant: -25/895*viewHeight)
            ])
        
    }
    
    @IBAction func save(sender: UIButton) {
        if (sender.titleLabel?.text == "Save") {
            if (d_name.text == "") {
                self.delegate?.showCheckpointCreationAlert()
                return
            }
            date = d_datePicker.date
            d_dateLabel.text = "by \(dateFormatter.string(from: date))"
            n_yesButton.setTitle("Save", for: .normal)
            n_noButton.setTitle("Cancel", for: .normal)
            let newCheckpoint = Checkpoint(id: -1, name: d_name.text!, date: netDateFormatter.string(from: date), isFinished: false, startDate: netDateFormatter.string(from: Date()), endDate: "")
            self.delegate?.createdCheckpoint(newCheckpoint: newCheckpoint)
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        if (sender.titleLabel?.text == "Cancel") {
            self.delegate?.cancelCreateCheckpoint()
        }
    }
    
    @objc func datePicked() {
        d_dateLabel.text = "by \(dateFormatter.string(from: d_datePicker.date))"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

