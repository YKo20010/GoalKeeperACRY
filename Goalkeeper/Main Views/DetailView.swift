//
//  DetailView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Lottie

protocol pickDate: class {
    func pickingDate()
}

class DetailView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: changeGoal?
    
    var d_description: UITextView!
    var d_progress: ProgressSlider!
    //var d_checkpoints: CustomTableView!
    var collectionView: UICollectionView!
    var headerView: HeaderView2!
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    let detailCellIdentifier = "DetailCellIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    var headerHeightConstraint: NSLayoutConstraint!
    var d_datePicker: UIDatePicker!
    
    var titles: [String] = ["checkpoints", "motivation"]
    
    var alert: UIAlertController!
    var saveButton: UIButton!
    var backButton: UIButton!
    let dateFormatter = DateFormatter()
    
    var t_Name: String = "Title"
    var t_Description: String = "default"
    var t_progress: Double = 0
    var t_Date: Date = Date()
    var t_checkpoints: [Checkpoint] = []
    
    let descriptionHeight: CGFloat = 25
    //let checkpointCellIdentifier = "CheckpointCellIdentifier"
    
    let co_background: UIColor = .white
    let co_textColor: UIColor = .white
    var co_psMinTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psThumbTrackTint: UIColor = UIColor(red: 174/255, green: 255/255, blue: 0/255, alpha: 1.0) //green
    var co_psMaxTrackTint: UIColor = .gray
    let co_cpTableViewText: UIColor = .white
    let co_cpTableViewBorder: UIColor = .white
    let co_datePickerTint: UIColor = .white
    let co_datePickerBackground: UIColor = .blue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = co_background
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
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
        
//        d_checkpoints = CustomTableView()
//        d_checkpoints.translatesAutoresizingMaskIntoConstraints = false
//        // d_checkpoints.dataSource = self
//        // d_checkpoints.register(DateTVC.self, forCellReuseIdentifier: checkpointCellIdentifier)
//        d_checkpoints.estimatedRowHeight = 100
//        d_checkpoints.rowHeight = UITableViewAutomaticDimension
//        d_checkpoints.backgroundColor = .clear
//        d_checkpoints.separatorColor = co_cpTableViewBorder
//        d_checkpoints.tintColor = co_cpTableViewText
//        // d_checkpoints.delegate = self
//        d_checkpoints.isScrollEnabled = false
//        view.addSubview(d_checkpoints)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailView.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = .clear
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(back), for: .touchDown)
        view.addSubview(backButton)
        
        viewHeight = view.frame.height
        headerView = HeaderView2(frame: .zero, viewHeight: viewHeight, viewWidth: viewWidth, t_Name: t_Name, t_Date: t_Date)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.delegate = self
        view.addSubview(headerView)
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .clear
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(co_textColor, for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchDown)
        view.addSubview(saveButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10/895*viewHeight
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalDetailCVC.self, forCellWithReuseIdentifier: detailCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
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
        
        alert = UIAlertController()
        alert.title = ""
        alert.message = ""
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: .none))
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
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
            d_progress.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 80),
            d_progress.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            d_progress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_progress.heightAnchor.constraint(equalToConstant: 20)
            ])
//        NSLayoutConstraint.activate([
//            d_checkpoints.topAnchor.constraint(equalTo: d_date.bottomAnchor, constant: 20),
//            d_checkpoints.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            d_checkpoints.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//            ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -37/895*viewHeight),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            d_datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    /******************************** MARK: Action Functions ********************************/
    @objc func save() {
        alert.message = ""
        if let nameText = headerView.d_name.text, nameText != "" {
            self.delegate?.changedName(newName: nameText)
        }
        if let descriptionText = d_description.text, descriptionText != "" {
            self.delegate?.changedDescription(newDescription: descriptionText)
        }
        
        self.delegate?.changedDate(newDate: t_Date)
        
        if (headerView.d_name.text == "") {
            alert.message = alert.message! + "Please input a [String] for the name of the goal."
            headerView.d_name.text = t_Name
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
    
    /****************   MARK: DatePicker ******************/
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        d_datePicker.isHidden = true
        headerView.d_date.isEnabled = true
        headerView.d_name.isEnabled = true
    }
    
    @objc func datePicked() {
        t_Date = d_datePicker.date
        headerView.d_date.setTitle("by " + dateFormatter.string(from: t_Date), for: .normal)
    }
    
/******************************** MARK: Collection View: Data Source & Delegate ********************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellIdentifier, for: indexPath) as! GoalDetailCVC
        cell.titleLabel.text = self.titles[indexPath.row]
        //cell.subtitleLabel.text = "Choose to start"
        // cell.layer.cornerRadius = 10
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (414 - 17 - 33)/414*viewWidth
        return CGSize(width: w, height: w/(364/148))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateHeader() {
        self.headerHeightConstraint.constant = 211/895*viewHeight
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
}

/******************************** MARK: Sticky Header ********************************/
extension DetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)/3
        }
        else if (scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 0) {
            self.headerHeightConstraint.constant -= abs(scrollView.contentOffset.y)
            if (self.headerHeightConstraint.constant < 0) {
                self.headerHeightConstraint.constant = 0
            }
        }
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (self.headerHeightConstraint.constant > 211/895*viewHeight) {
            animateHeader()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (self.headerHeightConstraint.constant > 211/895*viewHeight) {
            animateHeader()
        }
    }
}

extension DetailView: pickDate {
    func pickingDate() {
        d_datePicker.isHidden = false
    }
    
}

