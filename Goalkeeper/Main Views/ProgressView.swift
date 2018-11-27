//
//  ProgressView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

//
//  SettingView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

//protocol addedGoal: class {
//    func addGoal(newGoal: Goal)
//}

class ProgressView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var headerView: HeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    
    var tableView: UITableView!
    let reuseIdentifier = "progressCellReuseIdentifier"
    
    var goals: [Goal] = []
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        /*  TODO: Network and delete this   */
        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false)
        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false)
        let c3 = Checkpoint(name: "Checkpoint3", date: Date(), isFinished: true)
        let c4 = Checkpoint(name: "Checkpoint4", date: Date(), isFinished: true)
        
        let g1 = Goal(name: "asdfasdfasdfasdfasdf asdf as dasfdasdf", date: Date(timeInterval: 5256000, since: Date()), description: "description text 1", checkpoints: [], progress: 0)
        let g2 = Goal(name: "1/1", date: Date(timeInterval: 13140000, since: Date()), description: "description text 2", checkpoints: [c4], progress: 50)
        let g3 = Goal(name: "0/1", date: Date(timeInterval: 60*60*24*27+1, since: Date()), description: "text3", checkpoints: [c1], progress: 25)
        let g4 = Goal(name: "0/2", date: Date(timeInterval: 60*60*24*1+1, since: Date()), description: "text4", checkpoints: [c1, c2], progress: 77)
        let g5 = Goal(name: "1/3", date: Date(timeInterval: 31540000+1, since: Date()), description: "text5", checkpoints: [c1, c2, c3], progress: 33)
        let g6 = Goal(name: "2/4", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c1, c2, c3, c4], progress: 25)
        goals = [g1, g5, g6, g4, g2, g3]
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
        headerView = HeaderView(frame: .zero, textSize: 40/895*viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        headerView.titleLabel.text = "my progress"
        headerView.colorView.backgroundColor = UIColor(red: 244/255, green: 154/255, blue: 154/255, alpha: 1.0)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProgressTVC
        let goal = goals[indexPath.row]
        cell.configure(for: goal)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
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

//extension ProgressView: addedGoal {
//    func addGoal(newGoal: Goal) {
//        goals.append(newGoal)
//    }
//}

