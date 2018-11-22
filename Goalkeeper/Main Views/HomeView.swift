//
//  ViewController.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Hero

enum SearchType {
    case title
}

protocol changeGoal: class {
    func changedName(newName: String)
    func changedProgress(newProgress: Double)
    func changedDate(newDate: Date)
    func changedDescription(newDescription: String)
}

class HomeView: UIViewController, UISearchResultsUpdating, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
/*  Colors  */
    let co_background: UIColor = .white
    let co_searchBar: UIColor = .gray
    let co_searchBarTint: UIColor = .white
    let co_tabBar: UIColor = .darkGray
    var co_navBar: UIColor = .darkGray
    var co_text: UIColor = .white
/*  Views   */
    var collectionView: UICollectionView!
    var searchController: UISearchController!
    var addBarButton: UIBarButtonItem!
/*  Other   */
    var searchBy: SearchType = .title
    let goalCellIdentifier = "GoalCell"
    let headerReuseIdentifier = "headerReuseIdentifier"
    var headerHeightConstraint: NSLayoutConstraint!
    var selectedGoalIndex: Int = 0
    var selectedGoalIndex_goals: Int = 0
    let shadowRadius: CGFloat = 8
/*  Arrays  */
    var goals: [Goal] = []
    var selected_goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = co_background
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = co_tabBar
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let button: UIButton = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "defaultImage"), for: .normal)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addBarButton = UIBarButtonItem(customView: button)
        //      addBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addBarButton
        
        /*  TODO: Network and delete this   */
        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false)
        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false)
        let g1 = Goal(name: "Goal1", date: Date(), description: "description text 1", checkpoints: [], progress: 0)
        let g2 = Goal(name: "Goal2", date: Date(), description: "description text 2", checkpoints: [], progress: 50)
        let g3 = Goal(name: "Goal3", date: Date(), description: "text3", checkpoints: [c1], progress: 25)
        let g4 = Goal(name: "Goal4", date: Date(), description: "text4", checkpoints: [c1, c2], progress: 77)
        goals = [g1, g2, g3, g4]
        selected_goals = goals
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0.054*view.frame.height
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalCVC.self, forCellWithReuseIdentifier: goalCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Title"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = co_searchBar
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.layer.borderWidth = 0
        searchController.searchBar.tintColor = co_searchBarTint
        //tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        setupConstraints()
    
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.022*view.frame.width),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width)
            ])
    }
    
/******************************** MARK: Action Functions ********************************/
    
    @objc func add() {
        let newGoal = Goal(name: "New Goal", date: Date(), description: "Enter a description here.", checkpoints: [], progress: 0)
        goals.append(newGoal)
        selected_goals = goals
        collectionView.reloadData()
        collectionView.scrollToItem(at: NSIndexPath(row: goals.count-1, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    
/******************************** MARK: UICollectionView: Data Source ********************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selected_goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalCellIdentifier, for: indexPath) as! GoalCVC
        cell.titleLabel.text = selected_goals[indexPath.row].name
        cell.detailLabel.text = selected_goals[indexPath.row].description
        cell.backgroundColor = .white
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowRadius = shadowRadius
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.75
        cell.layer.shadowOffset = CGSize(width: 6, height: 6)
        cell.clipsToBounds = false
        cell.progressSlider.value = Float(selected_goals[indexPath.row].progress)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalCellIdentifier, for: indexPath) as! GoalCVC
        let goal = selected_goals[indexPath.row]
        selectedGoalIndex = indexPath.row
        selectedGoalIndex_goals = selected_goalsToGoals()
        let detailView = DetailView()
        detailView.delegate = self
        detailView.t_Name = goal.name
        detailView.t_Description = goal.description
        detailView.t_progress = goal.progress
        detailView.t_Date = goal.date
        detailView.t_checkpoints = goal.checkpoints
        self.present(detailView, animated: true, completion: nil)
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let w = 0.797*view.frame.width
        return CGSize(width: w, height: w/3.0)
    }
    
/******************************** MARK: UITableView: Delete Cell ********************************/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            goals.remove(at: indexPath.row)
            selected_goals = goals
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
/******************************** MARK: UISearchController Filtering ********************************/
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if !searchText.isEmpty {
                switch searchBy {
                case .title:
                    print("search by title")
                    selected_goals = goals.filter{$0.name.lowercased().contains(searchText.lowercased())}
                    collectionView.reloadData()
                }
            }
            else {
                selected_goals = goals
                collectionView.reloadData()
            }
        }
    }
    
/**Return the index of the goal in the "goals" array that corresponds to the goal in the "selected_goals" array.*/
    func selected_goalsToGoals() -> Int {
        if (goals.count>1) {
            for i in 0...goals.count-1 {
                if (goals[i].name == selected_goals[selectedGoalIndex].name
                    && goals[i].date == selected_goals[selectedGoalIndex].date
                    && goals[i].description == selected_goals[selectedGoalIndex].description
                    && goals[i].progress == selected_goals[selectedGoalIndex].progress) {
                    if (goals[i].checkpoints.count == 0) {
                        return i
                    }
                    else if (goals[i].checkpoints.count > 1) {
                        for j in 0...goals[i].checkpoints.count-1 {
                            if (!(goals[i].checkpoints[j] === selected_goals[selectedGoalIndex].checkpoints[j])) {
                                break
                            }
                        }
                        return i
                    }
                    else if (goals[i].checkpoints[0] === selected_goals[selectedGoalIndex].checkpoints[0]) {
                        return i
                    }
                }
            }
        }
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/******************************** MARK: Navigation Bar Customization ********************************/
extension HomeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
                //self.title = "Welcome Back!"
        }
        else if (scrollView.contentOffset.y > 0) {
                //self.title = "Goals"
        }
    }
}

extension HomeView: changeGoal {
    func changedName(newName: String) {
        goals[selectedGoalIndex_goals].name = newName
        selected_goals[selectedGoalIndex].name = newName
        collectionView.reloadData()
    }
    func changedProgress(newProgress: Double) {
        goals[selectedGoalIndex_goals].progress = newProgress
        selected_goals[selectedGoalIndex].progress = newProgress
        collectionView.reloadData()
    }
    func changedDate(newDate: Date) {
        goals[selectedGoalIndex_goals].date = newDate
        selected_goals[selectedGoalIndex].date = newDate
        collectionView.reloadData()
    }
    func changedDescription(newDescription: String) {
        goals[selectedGoalIndex_goals].description = newDescription
        selected_goals[selectedGoalIndex].description = newDescription
        collectionView.reloadData()
    }
}











