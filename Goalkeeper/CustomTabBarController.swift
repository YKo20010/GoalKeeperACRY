//
//  CustomTabBarController.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/20/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import Foundation
import UIKit
import Hero

protocol showDetail: class {
    func presentDetail(detailController: DetailView)
}
class CustomTabBarController: UITabBarController {
    
    let co_tabBarBackground: UIColor = .white
    let co_tabBarTint: UIColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    var nav_home: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.tabBar.layer.shadowRadius = 6
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5.0)
        self.tabBar.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        self.tabBar.layer.shadowOpacity = 0.75
        self.tabBar.clipsToBounds = false
        self.tabBar.layer.masksToBounds = false
    
        
/*********************     CUSTOMIZE TAB BAR APPEARANCE    ********************/
        view.isOpaque = true
        self.tabBar.barTintColor = co_tabBarBackground
        self.tabBar.tintColor = co_tabBarTint
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        
/*********************     HOME VIEW CONTROLLER    ********************/
        let homeController = HomeView()
        homeController.navigationItem.title = "Goals"
        homeController.delegateShowDetail = self
        nav_home = UINavigationController(rootViewController: homeController)
        nav_home.title = ""
        nav_home.tabBarItem.image = UIImage(named: "i_home")

/*********************     CALENDAR VIEW CONTROLLER    ********************/
        let calendarController = EventsView()
        calendarController.navigationItem.title = "Calendar"
        let nav_calendar = UINavigationController(rootViewController: calendarController)
        nav_calendar.title = ""
        nav_calendar.tabBarItem.image = UIImage(named:"i_cal")
        
/*********************     PROGRESS VIEW CONTROLLER    ********************/
        let progressController = ProgressView()
        progressController.navigationItem.title = "Progress"
        let nav_progress = UINavigationController(rootViewController: progressController)
        nav_progress.title = ""
        nav_progress.tabBarItem.image = UIImage(named: "i_prog")
        
        //homeController.delegate = progressController
        
/*********************     SETTINGS VIEW CONTROLLER    ********************/
        let settingController = SettingView()
        settingController.navigationItem.title = "Settings"
        let nav_setting = UINavigationController(rootViewController: settingController)
        nav_setting.title = ""
        nav_setting.tabBarItem.image = UIImage()
        
        
        homeController.delegate = calendarController
/*********************     Set ViewControllers for TabBarController    ********************/
        viewControllers = [nav_calendar, nav_home, nav_progress, nav_setting]
        //viewControllers = [nav_calendar, nav_progress]
    }
    
}

extension CustomTabBarController: showDetail {
    func presentDetail(detailController: DetailView) {
        self.nav_home.present(detailController, animated: true, completion: nil)
    }
}
