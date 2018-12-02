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
    
    override func viewDidAppear(_ animated: Bool) {
        netReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        netReload()
        
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        netDateFormatter.dateStyle = .medium
        netDateFormatter.timeStyle = .none
        netDateFormatter.dateFormat = "MM/dd/yyyy"
        
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
    
    func netReload() {
        NetworkManager.getGoals() { (goals) in
            self.goals = goals.filter{$0.endDate != "" && $0.user == self.user}
            self.selected_goals = goals.filter{$0.endDate != "" && $0.user == self.user}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        if let dateFromString = netDateFormatter.date(from: goal.endDate) {
            var timeDifference: CGFloat = CGFloat(dateFromString.timeIntervalSince(netDateFormatter.date(from: goal.date)!))
            timeDifference /= (60*60*24*365)
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

