//
//  DetailView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Lottie

class DetailView: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: changeGoal?
    
    var d_name: UITextField!
    var d_description: UITextView!
    var d_date: UIButton!
    var d_progress: ProgressSlider!
    var d_datePicker: UIDatePicker!
    var d_checkpoints: CustomTableView!
    
    var alert: UIAlertController!
    var saveButton: UIButton!
    var backButton: UIButton!
    let dateFormatter = DateFormatter()
    
    var t_Name: String = "default"
    var t_Description: String = "default"
    var t_progress: Double = 0
    var t_Date: Date = Date()
    var t_checkpoints: [Checkpoint] = []
    
    let nameHeight: CGFloat = 40
    let descriptionHeight: CGFloat = 25
    let dateHeight: CGFloat = 25
    let checkpointCellIdentifier = "CheckpointCellIdentifier"
    
    let co_background: UIColor = .white
    let co_textColor: UIColor = .black
    var co_psMinTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psThumbTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psMaxTrackTint: UIColor = .gray
    let co_datePickerTint: UIColor = .white
    let co_datePickerBackground: UIColor = .blue
    let co_cpTableViewText: UIColor = .white
    let co_cpTableViewBorder: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = co_background
        
        d_progress = ProgressSlider()
        d_progress.translatesAutoresizingMaskIntoConstraints = false
        d_progress.minimumValue = 0
        d_progress.maximumValue = 100
        d_progress.isEnabled = false
        d_progress.thumbTintColor = co_psThumbTrackTint
        d_progress.minimumTrackTintColor = co_psMinTrackTint
        d_progress.maximumTrackTintColor = co_psMaxTrackTint
        d_progress.value = Float(t_progress)
        d_progress.setThumbImage(UIImage(), for: .normal)
        view.addSubview(d_progress)
        
        d_name = UITextField()
        d_name.translatesAutoresizingMaskIntoConstraints = false
        d_name.backgroundColor = .clear
        d_name.textColor = co_textColor
        d_name.text = t_Name
        d_name.textAlignment = .center
        d_name.borderStyle = .none
        d_name.font = UIFont.boldSystemFont(ofSize: nameHeight-5)
        d_name.placeholder = "Goal"
        d_name.clearsOnBeginEditing = true
        view.addSubview(d_name)
        
        d_description = UITextView()
        d_description.translatesAutoresizingMaskIntoConstraints = false
        d_description.backgroundColor = .clear
        d_description.textColor = co_textColor
        d_description.text = t_Description
        d_description.textAlignment = .center
        d_description.isEditable = true
        d_description.scrollsToTop = true
        d_description.showsVerticalScrollIndicator = false
        d_description.font = UIFont.systemFont(ofSize: descriptionHeight - 5, weight: .medium)
        view.addSubview(d_description)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        d_date = UIButton()
        d_date.translatesAutoresizingMaskIntoConstraints = false
        d_date.setTitleColor(co_textColor, for: .normal)
        d_date.setTitle(dateFormatter.string(from: t_Date), for: .normal)
        d_date.addTarget(self, action: #selector(pickDate), for: .touchDown)
        view.addSubview(d_date)
        
        d_checkpoints = CustomTableView()
        d_checkpoints.translatesAutoresizingMaskIntoConstraints = false
       // d_checkpoints.dataSource = self
        d_checkpoints.register(DateTVC.self, forCellReuseIdentifier: checkpointCellIdentifier)
        d_checkpoints.estimatedRowHeight = 100
        d_checkpoints.rowHeight = UITableViewAutomaticDimension
        d_checkpoints.backgroundColor = .clear
        d_checkpoints.separatorColor = co_cpTableViewBorder
        d_checkpoints.tintColor = co_cpTableViewText
       // d_checkpoints.delegate = self
        d_checkpoints.isScrollEnabled = false
        view.addSubview(d_checkpoints)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailView.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        /*
         var d_datePicker: UIDatePicker!
         var d_checkpoints: [String]*/
        
        d_datePicker = UIDatePicker()
        d_datePicker.translatesAutoresizingMaskIntoConstraints = false
        d_datePicker.minimumDate = Date()
        d_datePicker.maximumDate = Date(timeInterval: 157700000, since: Date())
        d_datePicker.datePickerMode = .date
        d_datePicker.setValue(co_datePickerTint, forKey: "textColor")
        d_datePicker.backgroundColor = co_datePickerBackground
        d_datePicker.layer.cornerRadius = 5
        d_datePicker.layer.masksToBounds = true
        d_datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        d_datePicker.isHidden = true
        view.addSubview(d_datePicker)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .clear
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(co_textColor, for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchDown)
        view.addSubview(saveButton)
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(back), for: .touchDown)
        view.addSubview(backButton)
        
        alert = UIAlertController()
        alert.title = ""
        alert.message = ""
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: .none))
        
        setupConstraints()
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        d_datePicker.isHidden = true
        d_date.isEnabled = true
        d_description.isEditable = true
        d_name.isEnabled = true
    }
    
    @objc func pickDate() {
        d_datePicker.isHidden = false
        d_date.isEnabled = false
        d_description.isEditable = false
        d_name.isEnabled = false
    }
    
    @objc func datePicked() {
        d_date.setTitle(dateFormatter.string(from: d_datePicker.date), for: .normal)
        t_Date = d_datePicker.date
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        NSLayoutConstraint.activate([
            d_name.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            d_name.heightAnchor.constraint(equalToConstant: nameHeight),
            d_name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_name.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
            ])
        NSLayoutConstraint.activate([
            d_description.topAnchor.constraint(equalTo: d_progress.bottomAnchor, constant: 20),
            d_description.heightAnchor.constraint(equalToConstant: descriptionHeight + 20),
            d_description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_description.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
            ])
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        NSLayoutConstraint.activate([
            d_progress.topAnchor.constraint(equalTo: d_name.bottomAnchor, constant: 20),
            d_progress.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            d_progress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_progress.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            d_datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            d_date.topAnchor.constraint(equalTo: d_description.bottomAnchor, constant: 20),
            d_date.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            d_checkpoints.topAnchor.constraint(equalTo: d_date.bottomAnchor, constant: 20),
            d_checkpoints.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            d_checkpoints.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }

/******************************** MARK: UITableView: Data Source ********************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return t_checkpoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: checkpointCellIdentifier, for: indexPath) as! DateTVC
        cell.backgroundColor = .clear
        cell.date.text = dateFormatter.string(from: t_checkpoints[indexPath.row].date)
        cell.dateLabel.text = t_checkpoints[indexPath.row].name
        return cell
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
/******************************** MARK: Action Functions ********************************/
    @objc func save() {
        alert.message = ""
        if let nameText = d_name.text, nameText != "" {
            self.delegate?.changedName(newName: nameText)
        }
        if let descriptionText = d_description.text, descriptionText != "" {
            self.delegate?.changedDescription(newDescription: descriptionText)
        }

        self.delegate?.changedDate(newDate: t_Date)
        
        if (d_name.text == "") {
            alert.message = alert.message! + "Please input a [String] for the name of the goal."
            d_name.text = t_Name
        }
        if (d_description.text == "") {
            alert.message = alert.message! + "\nPlease input a [String] for the description."
            d_description.text = t_Description
        }
        if (alert.message != "") {
            self.present(alert, animated: true)
        }
        else {
            saveButton.isEnabled = false
            let checkAnimation = LOTAnimationView(name: "check_animation")
            checkAnimation.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            checkAnimation.center = self.view.center
            checkAnimation.contentMode = .scaleAspectFill
            view.addSubview(checkAnimation)
            checkAnimation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



