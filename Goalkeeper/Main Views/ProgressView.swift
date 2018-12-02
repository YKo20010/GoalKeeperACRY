//
//  ProgressView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

//protocol addedGoal: class {
//    func addGoal(newGoal: Goal)
//}

class ProgressView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: String = "acry@default.com"
    
    var headerView: HeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    
    var tableView: UITableView!
    let reuseIdentifier = "progressCellReuseIdentifier"
    
    var goals: [Goal] = []
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    override func viewDidAppear(_ animated: Bool) {
        netReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
    
        netReload()
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
        headerView = HeaderView(frame: .zero, textSize: 40/895*viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.titleLabel.text = "my progress"
        headerView.colorView.backgroundColor = UIColor(red: 244/255, green: 154/255, blue: 154/255, alpha: 1.0)
        headerView.layer.shadowOpacity = 0.0
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProgressTVC.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.isEditing = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 76/895*viewHeight),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36/414*viewWidth),
            tableView.widthAnchor.constraint(equalToConstant: 350/414*viewWidth),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    func netReload() {
        NetworkManager.getGoals() { (goals) in
            self.goals = goals.filter{$0.endDate == "" && $0.user == self.user}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProgressTVC
        let goal = goals[indexPath.row]
        cell.configure(for: goal)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        cell.goalID = goal.id
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71/895*viewHeight + 76/895*viewHeight
    }
    
    func animateHeader() {
        self.headerHeightConstraint.constant = 211/895*viewHeight
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

/******************************** MARK: Sticky Header ********************************/
extension ProgressView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)/3
        }
        else if (scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 0) {
            self.headerHeightConstraint.constant -= abs(scrollView.contentOffset.y)
            if (self.headerHeightConstraint.constant < 0) {
                self.headerHeightConstraint.constant = 0
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
