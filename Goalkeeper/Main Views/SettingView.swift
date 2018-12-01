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
    
    let signOutButton = UIButton()
    var headerView: calendarHeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    var profileImage: UIImageView!
    var url: URL!
    var nameLabel: UILabel!
    var goalsLabel: UILabel!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var completedGoals: Int = 0
    var goals: [Goal] = []
    
    var t_Name: String = "name"
    var t_Goals: String = "0 goals reached"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
//        /*  TODO: Network and delete this   */
//        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false, startDate: Date())
//        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false, startDate: Date())
//        let c3 = Checkpoint(name: "Checkpoint3", date: Date(), isFinished: true, startDate: Date())
//        c3.endDate = Date()
//        let c4 = Checkpoint(name: "Checkpoint4", date: Date(), isFinished: true, startDate: Date())
//        c4.endDate = Date()
//
//        let g1 = Goal(name: "0/0 checkpoints, 0% complete", date: Date(timeInterval: 5256000, since: Date()), description: "description text 1", checkpoints: [], startDate: Date())
//        let g2 = Goal(name: "1/1 checkpoints, 50% complete", date: Date(timeInterval: 13140000, since: Date()), description: "description text 2", checkpoints: [c4], startDate: Date())
//        let g3 = Goal(name: "0/1 checkpoints, 0% complete", date: Date(timeInterval: 60*60*24*27+1, since: Date()), description: "text3", checkpoints: [c1], startDate: Date())
//        let g4 = Goal(name: "0/2 checkpoints, 0% complete", date: Date(timeInterval: 60*60*24*1+1, since: Date()), description: "text4", checkpoints: [c1, c2], startDate: Date())
//        let g5 = Goal(name: "1/3 checkpoints, 25% complete", date: Date(timeInterval: 31540000+1, since: Date()), description: "text5", checkpoints: [c1, c2, c3], startDate: Date())
//        let g6 = Goal(name: "2/4 checkpoints, 40% complete", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c1, c2, c3, c4], startDate: Date())
//        let g7 = Goal(name: "2/2 checkpoints, 100% complete", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c3, c4], startDate: Date())
//        g7.endDate = Date()
//        let g8 = Goal(name: "0/0 checkpoints, 100% complete", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [], startDate: Date())
//        g8.endDate = Date()
//        let g9 = Goal(name: "1/2 checkpoints, 66% complete", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c2, c3], startDate: Date())
//        g9.endDate = Date()
//        goals = [g9, g7, g8, g1, g5, g6, g4, g2, g3]
        
        NetworkManager.getGoals() { (goals) in
            self.goals = goals
        }
        
        /*************************  Math for # goals reached    **********************/
        for goal in goals {
            var numCheck = 0
//            for checkpoint in goal.checkpoints {
//                if (checkpoint.isFinished) {
//                    numCheck += 1
//                }
//            }
            if (goal.endDate != nil) {
                numCheck += 1
            }
//            if (numCheck == goal.checkpoints.count + 1) {
//                completedGoals += 1
//            }
        }
        t_Goals = "\(completedGoals) goals reached"
        /**************************  Math for # goals reached    **********************/
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
        goalsLabel.text = t_Goals
        view.addSubview(goalsLabel)
        NSLayoutConstraint.activate([
            goalsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20/414*viewWidth),
            goalsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20/414*viewWidth),
            goalsLabel.heightAnchor.constraint(equalToConstant: 23/895*viewHeight),
            goalsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8/895*viewHeight)
            ])
        
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

