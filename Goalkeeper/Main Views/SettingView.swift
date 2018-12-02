//
//  SettingView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import GoogleSignIn
import GTMOAuth2
import Google

class SettingView: UIViewController {
    
    var user: String = "acry@default.com"
    var url: URL!
    
    let signOutButton = UIButton()
    var headerView: calendarHeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var goalsLabel: UILabel!
    var progressLabel: UILabel!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var completedGoals: Int = 0
    var activeGoals: Int = 0
    var goals: [Goal] = []
    
    var t_Name: String = "name"
    
    override func viewDidAppear(_ animated: Bool) {
        netReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
    
        headerView = calendarHeaderView(frame: .zero, textSize: 40/895*viewHeight, viewHeight: viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 127/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.titleLabel.text = "my profile"
        headerView.backgroundColor = UIColor(red: 165/255, green: 139/255, blue: 139/255, alpha: 1.0)
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.layer.borderColor = UIColor(red: 165/255, green: 139/255, blue: 139/255, alpha: 1.0).cgColor
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.cornerRadius = 53/895*viewHeight/2
        signOutButton.setTitle("sign out", for: .normal)
        signOutButton.setTitleColor(UIColor(red: 165/255, green: 139/255, blue: 139/255, alpha: 1.0), for: .normal)
        signOutButton.setTitleColor(UIColor(red: 145/255, green: 119/255, blue: 119/255, alpha: 1.0), for: .highlighted)
        signOutButton.addTarget(self, action: #selector(signOutWasPressed), for: .touchDown)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 26/895*viewHeight, weight: .light)
        signOutButton.titleLabel?.textAlignment = .center
        signOutButton.layer.masksToBounds = true
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -111/895*viewHeight),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 149/414*viewWidth),
            signOutButton.heightAnchor.constraint(equalToConstant: 53/895*viewHeight)
            ])
        
        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.profileImage.image = UIImage(data: data)
            }
        }
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 160/414*viewWidth/2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 2
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40/895*viewHeight),
            profileImage.widthAnchor.constraint(equalToConstant: 160/414*viewWidth),
            profileImage.heightAnchor.constraint(equalToConstant: 160/414*viewWidth)
            ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 26/895*viewHeight, weight: .semibold)
        nameLabel.text = t_Name
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20/414*viewWidth),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20/414*viewWidth),
            nameLabel.heightAnchor.constraint(equalToConstant: 33/895*viewHeight),
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant:33/895*viewHeight)
            ])
        
        goalsLabel = UILabel()
        goalsLabel.translatesAutoresizingMaskIntoConstraints = false
        goalsLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        goalsLabel.textAlignment = .center
        goalsLabel.font = UIFont.systemFont(ofSize: 18/895*viewHeight, weight: .regular)
        goalsLabel.text = "0 goals reached"
        view.addSubview(goalsLabel)
        NSLayoutConstraint.activate([
            goalsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20/414*viewWidth),
            goalsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20/414*viewWidth),
            goalsLabel.heightAnchor.constraint(equalToConstant: 23/895*viewHeight),
            goalsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8/895*viewHeight)
            ])
        
        progressLabel = UILabel()
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.systemFont(ofSize: 18/895*viewHeight, weight: .regular)
        progressLabel.text = "0 goals in progress"
        view.addSubview(progressLabel)
        NSLayoutConstraint.activate([
            progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20/414*viewWidth),
            progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20/414*viewWidth),
            progressLabel.heightAnchor.constraint(equalToConstant: 23/895*viewHeight),
            progressLabel.topAnchor.constraint(equalTo: goalsLabel.bottomAnchor, constant: 8/895*viewHeight)
            ])
        netReload()
    }
    
    func netReload() {
        NetworkManager.getGoals() { (goals) in
            self.goals = goals.filter{$0.user == self.user}
            self.completedGoals = 0
            self.activeGoals = 0
            /*************************  Math for # goals reached, in progress    **********************/
            for goal in self.goals {
                if (goal.endDate != "") {
                    self.completedGoals += 1
                }
                else {
                    self.activeGoals += 1
                }
            }
            if (self.completedGoals == 1) {
                self.goalsLabel.text = "\(self.completedGoals) goal reached"
            }
            else {
                self.goalsLabel.text = "\(self.completedGoals) goals reached"
            }
            if (self.activeGoals == 1) {
                self.progressLabel.text = "\(self.activeGoals) goal in progress"
            }
            else {
                self.progressLabel.text = "\(self.activeGoals) goals in progress"
            }
            /**************************  Math for # goals reached, in progress    **********************/
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    @IBAction func signOutWasPressed(sender: AnyObject) {
        signOutButton.layer.borderColor = UIColor(red: 145/255, green: 119/255, blue: 119/255, alpha: 1.0).cgColor
        GIDSignIn.sharedInstance().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

