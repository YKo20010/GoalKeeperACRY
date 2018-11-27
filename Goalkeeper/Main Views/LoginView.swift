//
//  LoginView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import Lottie

class LoginView: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    
    var rec: UIImageView!
    var titleLabel: UILabel!
    var subLabel: UILabel!
    var signInButton: GIDSignInButton!
    
    var rec2: UIImageView!
    var welcomeLabel: UILabel!
    var loadAnimation: LOTAnimationView!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
        view.addSubview(rec)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "GoalKeeper"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        view.addSubview(titleLabel)
        
        subLabel = UILabel()
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "created by A.C.R.Y."
        subLabel.textColor = .white
        subLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        view.addSubview(subLabel)
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        if (error != nil) {
            print(error)
            return
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().delegate = self
        
        signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        signInButton.layer.shadowRadius = 8
        signInButton.layer.shadowOpacity = 0.5
        signInButton.layer.masksToBounds = false
        signInButton.clipsToBounds = false
        signInButton.layer.shadowOffset = CGSize(width: 6, height: 6)
        signInButton.center = view.center
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            ])
        NSLayoutConstraint.activate([
            rec.topAnchor.constraint(equalTo: view.topAnchor),
            rec.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rec.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rec.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -50)
            ])
        NSLayoutConstraint.activate([
            subLabel.bottomAnchor.constraint(equalTo: rec.bottomAnchor, constant: -50),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: subLabel.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: subLabel.centerXAnchor)
            ])
        rec2 = UIImageView()
        rec2.translatesAutoresizingMaskIntoConstraints = false
        rec2.backgroundColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
        rec2.isHidden = true
        view.addSubview(rec2)
        welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.systemFont(ofSize: 40/895*view.frame.height, weight: .light)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        welcomeLabel.isHidden = true
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            rec2.topAnchor.constraint(equalTo: view.topAnchor),
            rec2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rec2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rec2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        loadAnimation = LOTAnimationView(name: "loading_dots")
        loadAnimation.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadAnimation.contentMode = .scaleAspectFit
        loadAnimation.isHidden = true
        loadAnimation.center = CGPoint(x: view.center.x, y: view.center.y + 50/895*view.frame.height)
        view.addSubview(loadAnimation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error != nil) {
            print("\(error.localizedDescription)")
            return
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            welcomeLabel.text = "Welcome, \(user.profile.name!)!"
            welcomeLabel.isHidden = false
            rec2.isHidden = false
            loadAnimation.isHidden = false
            loadAnimation.play()
            
            rec.isHidden = true
            titleLabel.isHidden = true
            subLabel.isHidden = true
            signInButton.isHidden = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                let tabview = CustomTabBarController()
                self.present(tabview, animated: true, completion: nil)
                self.welcomeLabel.text = "Welcome!"
                self.welcomeLabel.isHidden = true
                self.rec2.isHidden = true
                self.rec.isHidden = false
                self.titleLabel.isHidden = false
                self.subLabel.isHidden = false
                self.signInButton.isHidden = false
                self.loadAnimation.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
