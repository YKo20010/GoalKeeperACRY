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

class CustomTabBarController: UITabBarController {
    
    let co_tabBarBackground: UIColor = .white
    let co_tabBarTint: UIColor = .blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        
/*********************     CUSTOMIZE TAB BAR APPEARANCE    ********************/
        view.isOpaque = true
        self.tabBar.barTintColor = co_tabBarBackground
        self.tabBar.tintColor = co_tabBarTint
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        
/*********************     HOME VIEW CONTROLLER    ********************/
        let homeController = HomeView()
        homeController.navigationItem.title = "Goals"
        let nav_home = UINavigationController(rootViewController: homeController)
        nav_home.title = "Home"
        nav_home.tabBarItem.image = UIImage()

/*********************     CALENDAR VIEW CONTROLLER    ********************/
        let calendarController = CalendarView()
        calendarController.navigationItem.title = "Calendar"
        let nav_calendar = UINavigationController(rootViewController: calendarController)
        nav_calendar.title = "Calendar"
        nav_calendar.tabBarItem.image = UIImage(named:"defaultIcon")
        
/*********************     PROGRESS VIEW CONTROLLER    ********************/
        let progressController = ProgressView()
        progressController.navigationItem.title = "Progress"
        let nav_progress = UINavigationController(rootViewController: progressController)
        nav_progress.title = "Progress"
        nav_progress.tabBarItem.image = UIImage()
        
/*********************     Set ViewControllers for TabBarController    ********************/
        viewControllers = [nav_calendar, nav_home, nav_progress]
        //viewControllers = [nav_calendar, nav_progress]
    }
    
}
