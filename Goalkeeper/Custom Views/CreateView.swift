//
//  CreateView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/28/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class CreateView: UIView, UITextViewDelegate {
    
    var user: String = "acry@default.com"
    
    weak var delegate: createGoal?
    
    var d_name: UITextField!
    
    var date: Date = Date(timeIntervalSinceNow: 60*60*24)
    var d_date: UIButton!
    let dateFormatter = DateFormatter()
    var d_datePicker: UIDatePicker!
    
    var d_description: UITextView!
    
    var n_label: UILabel!
    var n_label2: UILabel!
    var n_yesButton: UIButton!
    var n_noButton: UIButton!
    var rec: UIImageView!
    
    var netDateFormatter: DateFormatter = DateFormatter()
    
    init(frame: CGRect, viewHeight: CGFloat, viewWidth: CGFloat) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 176/255, green: 210/255, blue: 232/255, alpha: 1.0)
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.dateFormat = "MM/dd/yyyy"
        
        d_name = UITextField()
        d_name.translatesAutoresizingMaskIntoConstraints = false
        d_name.backgroundColor = .clear
        d_name.textColor = .white
        d_name.text = "New Goal"
        d_name.textAlignment = .center
        d_name.borderStyle = .none
        d_name.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .regular)
        d_name.placeholder = "Enter Goal Name"
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
        
        n_label = UILabel()
        n_label.translatesAutoresizingMaskIntoConstraints = false
        n_label.text = "Finish By: "
        n_label.textColor = .white
        n_label.font = UIFont.systemFont(ofSize: 16/895*viewHeight, weight: .light)
        n_label.textAlignment = .left
        self.addSubview(n_label)
        NSLayoutConstraint.activate([
            n_label.leadingAnchor.constraint(equalTo: rec.leadingAnchor),
            n_label.topAnchor.constraint(equalTo: rec.bottomAnchor, constant: 10/895*viewHeight)
            ])
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        d_date = UIButton()
        d_date.translatesAutoresizingMaskIntoConstraints = false
        d_date.setTitleColor(.white, for: .normal)
        d_date.setTitle(dateFormatter.string(from: date), for: .normal)
        d_date.titleLabel?.font = UIFont.systemFont(ofSize: 16/895*viewHeight, weight: .light)
        d_date.titleLabel?.textAlignment = .left
        d_date.addTarget(self, action: #selector(pickDate), for: .touchDown)
        self.addSubview(d_date)
        NSLayoutConstraint.activate([
            d_date.centerYAnchor.constraint(equalTo: n_label.centerYAnchor),
            d_date.leadingAnchor.constraint(equalTo: n_label.trailingAnchor, constant: 20/414*viewWidth)
            ])

        n_label2 = UILabel()
        n_label2.translatesAutoresizingMaskIntoConstraints = false
        n_label2.text = "Description: "
        n_label2.textColor = .white
        n_label2.font = UIFont.systemFont(ofSize: 20/895*viewHeight, weight: .regular)
        n_label2.textAlignment = .left
        self.addSubview(n_label2)
        NSLayoutConstraint.activate([
            n_label2.leadingAnchor.constraint(equalTo: rec.leadingAnchor),
            n_label2.topAnchor.constraint(equalTo: n_label.bottomAnchor, constant: 10/895*viewHeight)
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
        
        d_description = UITextView()
        d_description.translatesAutoresizingMaskIntoConstraints = false
        d_description.backgroundColor = .clear
        d_description.textColor = .white
        d_description.text = "type yourself a reminder of what you want to accomplish, and why you want to achieve this goal"
        d_description.textAlignment = .left
        d_description.isEditable = true
        d_description.scrollsToTop = true
        d_description.showsVerticalScrollIndicator = false
        d_description.font = UIFont.systemFont(ofSize: 16/895*viewHeight, weight: .light)
        d_description.delegate = self
        self.addSubview(d_description)
        NSLayoutConstraint.activate([
            d_description.leadingAnchor.constraint(equalTo: rec.leadingAnchor),
            d_description.trailingAnchor.constraint(equalTo: rec.trailingAnchor),
            d_description.topAnchor.constraint(equalTo: n_label2.bottomAnchor, constant: 10/895*viewHeight),
            d_description.bottomAnchor.constraint(equalTo: n_noButton.topAnchor, constant: -25/895*viewHeight)
            ])
        
        d_datePicker = UIDatePicker()
        d_datePicker.translatesAutoresizingMaskIntoConstraints = false
        d_datePicker.minimumDate = Date()
        d_datePicker.maximumDate = Date(timeIntervalSinceNow: 60*60*24*365*5)
        d_datePicker.datePickerMode = .date
        d_datePicker.setValue(UIColor.white, forKey: "textColor")
        d_datePicker.backgroundColor = UIColor(red: 176/255, green: 210/255, blue: 232/255, alpha: 1.0)
        d_datePicker.layer.cornerRadius = 5
        d_datePicker.layer.masksToBounds = true
        d_datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        d_datePicker.isHidden = true
        d_datePicker.tintColor = .white
        self.addSubview(d_datePicker)
        NSLayoutConstraint.activate([
            d_datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20/414*viewWidth),
            d_datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20/414*viewWidth),
            d_datePicker.bottomAnchor.constraint(equalTo: n_noButton.topAnchor, constant: -25/895*viewHeight),
            d_datePicker.heightAnchor.constraint(equalTo:d_datePicker.widthAnchor)
            ])
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        d_description.text = ""
    }
    
    @IBAction func save(sender: UIButton) {
        //or set datePicker
        if (sender.titleLabel?.text == "Save") {
            if (d_name.text == "") {
                self.delegate?.showCreationAlert()
                return
            }
//            let newGoal = Goal(name: d_name.text!, date: netDateFormatter.string(from: date), description: d_description.text!, checkpoints: [], startDate: netDateFormatter.string(from: Date()), endDate: nil)
            let newGoal = Goal(id: -1, name: d_name.text!, user: user, date: netDateFormatter.string(from: date), description: d_description.text!, startDate: netDateFormatter.string(from: Date()), endDate: nil)
            self.delegate?.createdGoal(newGoal: newGoal)
        }
        if (sender.titleLabel?.text == "Set") {
            date = d_datePicker.date
            d_date.setTitle(dateFormatter.string(from: date), for: .normal)
            d_datePicker.isHidden = true
            d_date.isEnabled = true
            d_name.isEnabled = true
            n_yesButton.setTitle("Save", for: .normal)
            n_noButton.setTitle("Cancel", for: .normal)
            d_description.isEditable = true
        }
        
    }
    
    @IBAction func cancel(sender: UIButton) {
        //or cancel datePicker
        if (sender.titleLabel?.text == "Cancel") {
            self.delegate?.cancelCreate()
        }
        if (sender.titleLabel?.text == "Back") {
            d_date.setTitle(dateFormatter.string(from: date), for: .normal)
            d_datePicker.isHidden = true
            d_date.isEnabled = true
            d_name.isEnabled = true
            n_yesButton.setTitle("Save", for: .normal)
            n_noButton.setTitle("Cancel", for: .normal)
            d_description.isEditable = true
        }
    }
    
    @objc func pickDate() {
        d_datePicker.isHidden = false
        d_date.isEnabled = false
        d_name.isEnabled = false
        n_yesButton.setTitle("Set", for: .normal)
        n_noButton.setTitle("Back", for: .normal)
        d_description.isEditable = false
    }
    
    @objc func datePicked() {
        d_date.setTitle(dateFormatter.string(from: d_datePicker.date), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
