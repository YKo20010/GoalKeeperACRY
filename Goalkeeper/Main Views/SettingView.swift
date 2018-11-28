//
//  SettingView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import GoogleSignIn

class SettingView: UIViewController {
    
    var headerView: calendarHeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    //var scrollView: UIScrollView!
    
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
        headerView.titleLabel.text = "settings"
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        let signOutButton = UIButton()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.blue, for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutWasPressed), for: .touchDown)
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
    
    }
    
    @IBAction func signOutWasPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

