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
    //var scrollView: UIScrollView!
    var profileImage: UIImageView!
    var url: URL!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
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
        headerView.titleLabel.text = ""
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.layer.borderColor = UIColor(red: 235/255, green: 195/255, blue: 143/255, alpha: 1.0).cgColor
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.cornerRadius = 8
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(UIColor(red: 235/255, green: 195/255, blue: 143/255, alpha: 1.0), for: .normal)
        signOutButton.setTitleColor(UIColor(red: 185/255, green: 145/255, blue: 93/255, alpha: 1.0), for: .highlighted)
        signOutButton.addTarget(self, action: #selector(signOutWasPressed), for: .touchDown)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        signOutButton.layer.masksToBounds = true
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 100/414*viewWidth)
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
        profileImage.layer.cornerRadius = 100/414*viewWidth/2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 2
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: headerView.bottomAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100/414*viewWidth),
            profileImage.heightAnchor.constraint(equalToConstant: 100/414*viewWidth)
            ])
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    @IBAction func signOutWasPressed(sender: AnyObject) {
        signOutButton.layer.borderColor = UIColor(red: 185/255, green: 145/255, blue: 93/255, alpha: 1.0).cgColor
        GIDSignIn.sharedInstance().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

