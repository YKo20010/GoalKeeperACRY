//
//  HistoryViewViewController.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/30/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class HistoryView: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource {
    var user: String = "acry@default.com"

    /*  Views   */
    var tableView: UITableView!
    var searchController: UISearchBar!
    var headerView: HeaderView!
    /*  Other   */
    let goalCellIdentifier = "CompletedGoalCell"
    let headerReuseIdentifier = "headerReuseIdentifier"
    var headerHeightConstraint: NSLayoutConstraint!
    /*  Arrays  */
    var goals: [Goal] = []
    var selected_goals: [Goal] = []
    
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var netDateFormatter: DateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.dateFormat = "MM/dd/yyyy"
        
//        /*  TODO: Network and delete this   */
//        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false, startDate: Date())
//        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false, startDate: Date())
//        let c3 = Checkpoint(name: "Checkpoint3", date: Date(), isFinished: true, startDate: Date())
//        c3.endDate = Date()
//        let c4 = Checkpoint(name: "Checkpoint4", date: Date(), isFinished: true, startDate: Date())
//        c4.endDate = Date()
//        let c5 = Checkpoint(name: "Checkpoint5", date: Date(), isFinished: false, startDate: Date())
//        let c6 = Checkpoint(name: "Checkpoint6", date: Date(), isFinished: false, startDate: Date())
//        let c7 = Checkpoint(name: "Checkpoint7", date: Date(), isFinished: true, startDate: Date())
//        c7.endDate = Date()
//        let c8 = Checkpoint(name: "Checkpoint8", date: Date(), isFinished: true, startDate: Date())
//        c8.endDate = Date()
//        let c9 = Checkpoint(name: "Checkpoint9", date: Date(), isFinished: false, startDate: Date())
//        let c10 = Checkpoint(name: "Checkpoint10", date: Date(), isFinished: false, startDate: Date())
//        let c11 = Checkpoint(name: "Checkpoint11", date: Date(), isFinished: true, startDate: Date())
//        c11.endDate = Date()
//        let c12 = Checkpoint(name: "Checkpoint12", date: Date(), isFinished: true, startDate: Date())
//        c12.endDate = Date()
//        let c13 = Checkpoint(name: "Checkpoint13", date: Date(), isFinished: false, startDate: Date())
//        let c14 = Checkpoint(name: "Checkpoint14", date: Date(), isFinished: false, startDate: Date())
//        let c15 = Checkpoint(name: "Checkpoint15", date: Date(), isFinished: true, startDate: Date())
//        c15.endDate = Date()
//        let c16 = Checkpoint(name: "Checkpoint16", date: Date(), isFinished: true, startDate: Date())
//        c16.endDate = Date()
//
//
//        let g1 = Goal(name: "1", date: Date(timeInterval: 5256000, since: Date()), description: "description text 1", checkpoints: [], startDate: Date())
//        let g2 = Goal(name: "2", date: Date(timeInterval: 13140000, since: Date()), description: "description text 2", checkpoints: [c4], startDate: Date())
//        let g3 = Goal(name: "3", date: Date(timeInterval: 60*60*24*27+1, since: Date()), description: "text3", checkpoints: [c1], startDate: Date())
//        let g4 = Goal(name: "4", date: Date(timeInterval: 60*60*24*1+1, since: Date()), description: "text4", checkpoints: [c5, c2], startDate: Date())
//        let g5 = Goal(name: "5", date: Date(timeInterval: 31540000+1, since: Date()), description: "text5", checkpoints: [c6, c7, c3], startDate: Date())
//        let g6 = Goal(name: "6", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c8, c9, c10, c11], startDate: Date())
//        let g7 = Goal(name: "After", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c12, c13], startDate: Date())
//        g7.endDate = Date(timeInterval: 60*60*24*365*11, since: Date())
//        let g8 = Goal(name: "Before", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [], startDate: Date())
//        g8.endDate = Date(timeInterval: 60*60*24*365, since: Date())
//        let g9 = Goal(name: "At", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c14, c15], startDate: Date())
//        g9.endDate = Date(timeInterval: 60*60*24*365*10+1, since: Date())
//        goals = [g9, g7, g8, g1, g5, g6, g4, g2, g3]
        
        NetworkManager.getGoals() { (goals) in
            self.goals = goals
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        getFinishedGoals()
        selected_goals = goals
        
        headerView = HeaderView(frame: .zero, textSize: 40/895*viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.layer.shadowOpacity = 0.0
        headerView.titleLabel.text = "history"
        headerView.backgroundColor = UIColor(red: 159/255, green: 171/255, blue: 184/255, alpha: 1.0)
        headerView.colorView.backgroundColor = UIColor(red: 159/255, green: 171/255, blue: 184/255, alpha: 1.0)
        view.addSubview(headerView)
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(historyTVC.self, forCellReuseIdentifier: goalCellIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        searchController = UISearchBar()
        searchController.translatesAutoresizingMaskIntoConstraints = false
        searchController.sizeToFit()
        searchController.barTintColor = .white
        searchController.isTranslucent = false
        searchController.layer.borderWidth = 0
        searchController.tintColor = .black
        searchController.delegate = self
        view.addSubview(searchController)
        definesPresentationContext = true
        
        setupConstraints()
    }
    
    func getFinishedGoals() {
        goals = goals.filter{$0.endDate != nil}
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchController.text {
            if !searchText.isEmpty {
                selected_goals = goals.filter{$0.name.lowercased().contains(searchText.lowercased())}
                tableView.reloadData()
            }
            else {
                selected_goals = goals
                tableView.reloadData()
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            searchController.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            searchController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchController.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchController.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor)
            ])

    }
    
    /******************************** MARK: UITableView: Data Source ********************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: goalCellIdentifier, for: indexPath) as! historyTVC
        let goal = selected_goals[indexPath.row]
        cell.configure(for: goal)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        var timeDifference: CGFloat = CGFloat(netDateFormatter.date(from: goal.endDate!)!.timeIntervalSince(netDateFormatter.date(from: goal.date)!))
        timeDifference /= (60*60*24*365)
//        if (timeDifference < -365) {
//            cell.tab.backgroundColor = UIColor(red: 178/255, green: 255/255, blue: 178/255, alpha: 1.0)
//        }
        if (timeDifference > (255 - 178)) {
            timeDifference = 255 - 178
        }
        if (timeDifference < -255 + 178) {
            timeDifference = 178 - 255
        }
        if (timeDifference < 0) {
            cell.tab.backgroundColor = UIColor(red: (255 - (178 + abs(timeDifference)))/255, green: 255/255, blue: 178/255, alpha: 1.0)
        }
        else {
            cell.tab.backgroundColor = UIColor(red: 255/255, green: (255 - timeDifference)/255, blue: 178/255, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selected_goals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187/414*viewWidth
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

/******************************** MARK: Navigation Bar Customization ********************************/
/******************************** MARK: Sticky Header ********************************/
extension HistoryView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)/3
            self.headerView.titleLabel.isHidden = false
        }
        else if (scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 0) {
            self.headerHeightConstraint.constant -= abs(scrollView.contentOffset.y)
            if (self.headerHeightConstraint.constant < 0) {
                self.headerHeightConstraint.constant = 0
                self.headerView.titleLabel.isHidden = true
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
