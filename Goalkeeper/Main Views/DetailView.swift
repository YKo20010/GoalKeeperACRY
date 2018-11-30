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

protocol ChangeMotivationTitleDelegate: class{
    func changedMotivationText(newTitle: String)
}

protocol ChangeCheckpointStatus: class {
    func changedCheckpointStatus(newCheckpoint: [Checkpoint])
}

class DetailView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: changeGoal?
    
    var collectionView: UICollectionView!
    var headerView: HeaderView2!
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    let detailCellIdentifier = "DetailCellIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    var headerHeightConstraint: NSLayoutConstraint!
    var d_datePicker: UIDatePicker!
    var blurView: UIVisualEffectView!
    var datePickLabel: UILabel!
    
    var titles: [String] = ["checkpoints", "motivation"]
    
    var alert: UIAlertController!
    var saveButton: UIButton!
    var backButton: UIButton!
    let dateFormatter = DateFormatter()
    
    var t_Name: String = "Title"
    var t_Description: String = "default"
    var t_Date: Date = Date()
    var t_checkpoints: [Checkpoint] = []
    var h: CGFloat = 0
    
    let descriptionHeight: CGFloat = 25
    let checkpointCellIdentifier = "CheckpointCellIdentifier"
    
    let co_background: UIColor = .white
    let co_textColor: UIColor = .white
    let co_cpTableViewText: UIColor = .white
    let co_cpTableViewBorder: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = co_background
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        //to calculate checkpoints cell height (gives an error if moved to collectionview func)
        h = 0.14525*viewHeight + 0.059218*viewHeight*CGFloat(t_checkpoints.count)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        viewHeight = view.frame.height
        headerView = HeaderView2(frame: .zero, viewHeight: viewHeight, viewWidth: viewWidth, t_Name: t_Name, t_Date: t_Date)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.delegate = self
        view.addSubview(headerView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 61/895*viewHeight
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalDetailCVC.self, forCellWithReuseIdentifier: detailCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.isHidden = true
        view.addSubview(blurView)
        
        d_datePicker = UIDatePicker()
        d_datePicker.translatesAutoresizingMaskIntoConstraints = false
        d_datePicker.minimumDate = Date()
        d_datePicker.maximumDate = Date(timeInterval: 60*60*24*365*10, since: Date())
        d_datePicker.datePickerMode = .date
        d_datePicker.setValue(UIColor.white, forKey: "textColor")
        d_datePicker.backgroundColor = UIColor.clear
        d_datePicker.layer.cornerRadius = 5
        d_datePicker.layer.masksToBounds = true
        d_datePicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        d_datePicker.isHidden = true
        view.addSubview(d_datePicker)
        
        datePickLabel = UILabel()
        datePickLabel.translatesAutoresizingMaskIntoConstraints = false
        datePickLabel.textColor = .white
        datePickLabel.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .regular)
        datePickLabel.isHidden = true
        view.addSubview(datePickLabel)
        
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = .white
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchDown)
        backButton.layer.cornerRadius = 8
        backButton.layer.masksToBounds = true
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        backButton.titleLabel?.textAlignment = .center
        backButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
        backButton.layer.borderWidth = 1
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20/895*viewHeight),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50/895*viewHeight),
            backButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            backButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -50/895*viewHeight)
            ])
        
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .white
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchDown)
        saveButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.layer.masksToBounds = true
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        saveButton.titleLabel?.textAlignment = .center
        saveButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
        saveButton.layer.borderWidth = 1
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20/895*viewHeight),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50/895*viewHeight),
            saveButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 50/895*viewHeight)
            ])
        
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
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -37/895*viewHeight),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            d_datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            d_datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            datePickLabel.bottomAnchor.constraint(equalTo: d_datePicker.topAnchor, constant: -20/895*viewHeight),
            datePickLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    /******************************** MARK: Action Functions ********************************/
    @objc func back() {
        if (backButton.titleLabel?.text == "Back") {
            dismiss(animated: true, completion: nil)
        }
        else {
            backButton.backgroundColor = .white
            saveButton.backgroundColor = .white
            d_datePicker.isHidden = true
            datePickLabel.isHidden = true
            blurView.isHidden = true
            headerView.d_date.isEnabled = true
            headerView.d_name.isEnabled = true
            saveButton.setTitle("Save", for: .normal)
            saveButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
            saveButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
            backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
            backButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
        }
    }
    
    @objc func save() {
        if (saveButton.titleLabel?.text == "Save") {
            alert.message = ""
            if let nameText = headerView.d_name.text, nameText != "" {
                self.delegate?.changedName(newName: nameText)
            }
            if (headerView.d_name.text == "") {
                alert.message = alert.message! + "Please input a [String] for the name of the goal."
                headerView.d_name.text = t_Name
            }
            if (alert.message != "") {
                self.present(alert, animated: true)
            }
            else {
                self.delegate?.changedCheckpoint(newCheckpoint: t_checkpoints)
                self.delegate?.changedDescription(newDescription: t_Description)
                self.delegate?.changedDate(newDate: t_Date)
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
        else {
            backButton.backgroundColor = .white
            saveButton.backgroundColor = .white
            d_datePicker.isHidden = true
            datePickLabel.isHidden = true
            blurView.isHidden = true
            headerView.d_date.isEnabled = true
            headerView.d_name.isEnabled = true
            saveButton.setTitle("Save", for: .normal)
            saveButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
            saveButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
            backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65), for: .normal)
            backButton.layer.borderColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65).cgColor
            t_Date = d_datePicker.date
            headerView.d_date.setTitle("by " + dateFormatter.string(from: t_Date), for: .normal)
        }
    }
    
    @objc func datePicked() {
        datePickLabel.text = "\(dateFormatter.string(from: d_datePicker.date))"
    }
    
    /******************************** MARK: Collection View: Data Source & Delegate ********************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellIdentifier, for: indexPath) as! GoalDetailCVC
        cell.viewHeight = self.viewHeight
        cell.viewWidth = self.viewWidth
        cell.checkpoints = t_checkpoints
        cell.setupConstraints()
        cell.titleLabel.text = self.titles[indexPath.item]
        cell.motivationTextView.text = t_Description
        if (titles[indexPath.item] == "motivation") {
            cell.motivationTextView.isHidden = false
            cell.delegate = self
            cell.tableView.isHidden = true
        }
        else {
            cell.motivationTextView.isHidden = true
            cell.delegate2 = self
            cell.tableView.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = viewWidth!
        if (titles[indexPath.item] == "checkpoints") {
            return CGSize(width: w, height: h)
        }
        else {
            return CGSize(width: w, height: 228/895*viewHeight)
        }
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

/******************************** MARK: Extensions ********************************/
extension DetailView: ChangeMotivationTitleDelegate {
    func changedMotivationText(newTitle: String) {
        t_Description = newTitle
    }
}

extension DetailView: pickDate {
    func pickingDate() {
        datePickLabel.text = "\(dateFormatter.string(from: d_datePicker.date))"
        d_datePicker.isHidden = false
        blurView.isHidden = false
        datePickLabel.isHidden = false
        saveButton.setTitle("Set", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.layer.borderColor = UIColor.white.cgColor
        backButton.setTitle("Cancel", for: .normal)
        backButton.backgroundColor = .clear
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.borderColor = UIColor.white.cgColor
    }
}

extension DetailView: ChangeCheckpointStatus {
    func changedCheckpointStatus(newCheckpoint: [Checkpoint]) {
        t_checkpoints = newCheckpoint
        self.collectionView.reloadData()
    }
}


