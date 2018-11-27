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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let signOutButton = UIButton()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.blue, for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutWasPressed), for: .touchDown)
        view.addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
