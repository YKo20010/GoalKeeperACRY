//
//  ViewController.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import Hero
import EventKit

enum SearchType {
    case title
}

protocol changeGoal: class {
    func changedName(newName: String)
    func changedProgress(newProgress: Double)
    func changedDate(newDate: Date)
    func changedDescription(newDescription: String)
}

protocol createGoal: class {
    func createdGoal(newGoal: Goal)
    func cancelCreate()
    func showCreationAlert()
}

class HomeView: UIViewController, UISearchResultsUpdating, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //weak var delegate: addedGoal?
    weak var delegate: addEvent?
    weak var delegateShowDetail: showDetail?
    
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
    var headerView: HeaderView!
    var addButton: UIButton!
    var rec: UIImageView!
    var plusSign: UILabel!
    var createView: CreateView!
    var alert: UIAlertController!
    var blurView: UIVisualEffectView!
    /*  Delete Goal Notification    */
    var n_background: UIImageView!
    var n_label: UILabel!
    var n_nameLabel: UILabel!
    var n_yesButton: UIButton!
    var n_noButton: UIButton!
    var deleteIndex: IndexPath!
    /*  Other   */
    var searchBy: SearchType = .title
    let goalCellIdentifier = "GoalCell"
    let headerReuseIdentifier = "headerReuseIdentifier"
    var headerHeightConstraint: NSLayoutConstraint!
    var selectedGoalIndex: Int = 0
    var selectedGoalIndex_goals: Int = 0
    /*  Arrays  */
    var goals: [Goal] = []
    var selected_goals: [Goal] = []
    var dateFormatter = DateFormatter()
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = co_background
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = co_tabBar
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
        let button: UIButton = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "defaultImage"), for: .normal)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = addBarButton
        
        /*  TODO: Network and delete this   */
        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false, startDate: Date())
        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false, startDate: Date())
        let c3 = Checkpoint(name: "Checkpoint3", date: Date(), isFinished: true, startDate: Date())
        let c4 = Checkpoint(name: "Checkpoint4", date: Date(), isFinished: true, startDate: Date())
        
        let g1 = Goal(name: "0/0lkjas;dlfkadkfj;asdkljf;aslkdfj;askdjf;asjd;fjas;dlfjka", date: Date(timeInterval: 5256000, since: Date()), description: "description text 1", checkpoints: [], progress: 0, startDate: Date())
        let g2 = Goal(name: "1/1", date: Date(timeInterval: 13140000, since: Date()), description: "description text 2", checkpoints: [c4], progress: 50, startDate: Date())
        let g3 = Goal(name: "0/1", date: Date(timeInterval: 60*60*24*27+1, since: Date()), description: "text3", checkpoints: [c1], progress: 25, startDate: Date())
        let g4 = Goal(name: "0/2", date: Date(timeInterval: 60*60*24*1+1, since: Date()), description: "text4", checkpoints: [c1, c2], progress: 77, startDate: Date())
        let g5 = Goal(name: "1/3", date: Date(timeInterval: 31540000+1, since: Date()), description: "text5", checkpoints: [c1, c2, c3], progress: 33, startDate: Date())
        let g6 = Goal(name: "2/4", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c1, c2, c3, c4], progress: 100, startDate: Date())
        goals = [g1, g2, g3, g4, g5, g6]
        selected_goals = goals
        
        headerView = HeaderView(frame: .zero, textSize: 40/895*viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 211/895*viewHeight)
        headerHeightConstraint.isActive = true
        view.addSubview(headerView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10/895*viewHeight
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalCVC.self, forCellWithReuseIdentifier: goalCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        //rec to make addButton opaque
        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = .white
        rec.layer.cornerRadius = 39/895*viewHeight/2
        view.addSubview(rec)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
        addButton.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
        addButton.layer.shadowRadius = 8
        addButton.layer.cornerRadius = 39/895*viewHeight/2
        addButton.layer.masksToBounds = false
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowOffset = CGSize(width: 6, height: 6)
        addButton.clipsToBounds = false
        addButton.addTarget(self, action:#selector(add), for: .touchDown)
        view.addSubview(addButton)
        
        plusSign = UILabel()
        plusSign.translatesAutoresizingMaskIntoConstraints = false
        plusSign.text = "+"
        plusSign.textColor = .white
        plusSign.font = UIFont.systemFont(ofSize: 30/414*viewWidth, weight: .regular)
        view.addSubview(plusSign)
        
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
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.isHidden = true
        view.addSubview(blurView)
        
        createView = CreateView(frame: .zero, viewHeight: viewHeight, viewWidth: viewWidth)
        createView.translatesAutoresizingMaskIntoConstraints = false
        createView.delegate = self
        createView.isHidden = true
        view.addSubview(createView)
        
        alert = UIAlertController()
        alert.title = "Invalid Goal Name"
        alert.message = "Please input a [String] for the name of the goal."
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: .none))
        
        setupConstraints()
        setupDeleteGoalNotification()
    }

    /******************************** MARK: Swipe Delete Notification Setup ********************************/
    private func setupDeleteGoalNotification() {
        deleteIndex = nil
        
        n_background = UIImageView()
        n_background.translatesAutoresizingMaskIntoConstraints = false
        n_background.backgroundColor = UIColor(red: 176/255, green: 210/255, blue: 232/255, alpha: 1.0)
        n_background.layer.cornerRadius = 8
        view.addSubview(n_background)
        n_background.isHidden = true
        NSLayoutConstraint.activate([
            n_background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            n_background.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            n_background.widthAnchor.constraint(equalToConstant: 4/5*viewWidth),
            n_background.heightAnchor.constraint(equalToConstant: 4/5*viewWidth)
            ])
        
//        n_background.layer.shadowColor = UIColor(red: 190/255, green: 172/255, blue: 172/255, alpha: 1.0).cgColor
//        n_background.layer.shadowRadius = 8
//        n_background.layer.shadowOpacity = 0.5
//        n_background.layer.shadowOffset = CGSize(width: 6, height: 6)
//        n_background.clipsToBounds = false
//        n_background.layer.masksToBounds = false
        
        n_label = UILabel()
        n_label.translatesAutoresizingMaskIntoConstraints = false
        n_label.text = "Do you want to delete the goal: "
        n_label.textColor = .white
        n_label.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        n_label.textAlignment = .center
        n_label.numberOfLines = 0
        view.addSubview(n_label)
        n_label.isHidden = true
        NSLayoutConstraint.activate([
            n_label.leadingAnchor.constraint(equalTo: n_background.leadingAnchor, constant: 20/895*viewHeight),
            n_label.trailingAnchor.constraint(equalTo: n_background.trailingAnchor, constant: -20/895*viewHeight),
            n_label.topAnchor.constraint(equalTo: n_background.topAnchor, constant: 20/895*viewHeight)
            ])
        
        n_nameLabel = UILabel()
        n_nameLabel.translatesAutoresizingMaskIntoConstraints = false
        n_nameLabel.text = "Goal Name"
        n_nameLabel.textColor = .white
        n_nameLabel.font = UIFont.systemFont(ofSize: 45/895*viewHeight, weight: .regular)
        n_nameLabel.textAlignment = .center
        view.addSubview(n_nameLabel)
        n_nameLabel.isHidden = true
        NSLayoutConstraint.activate([
            n_nameLabel.leadingAnchor.constraint(equalTo: n_background.leadingAnchor, constant: 20/895*viewHeight),
            n_nameLabel.trailingAnchor.constraint(equalTo: n_background.trailingAnchor, constant: -20/895*viewHeight),
            n_nameLabel.topAnchor.constraint(equalTo: n_label.bottomAnchor, constant: 20/895*viewHeight)
            ])

        n_yesButton = UIButton()
        n_yesButton.translatesAutoresizingMaskIntoConstraints = false
        n_yesButton.backgroundColor = UIColor.clear
        n_yesButton.setTitleColor(UIColor.white, for: .normal)
        n_yesButton.layer.cornerRadius = 8
        n_yesButton.layer.masksToBounds = true
        n_yesButton.addTarget(self, action:#selector(delete(sender:)), for: .touchDown)
        n_yesButton.setTitle("Yes", for: .normal)
        n_yesButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        n_yesButton.titleLabel?.textAlignment = .center
        n_yesButton.layer.borderColor = UIColor.white.cgColor
        n_yesButton.layer.borderWidth = 1
        view.addSubview(n_yesButton)
        n_yesButton.isHidden = true
        NSLayoutConstraint.activate([
            n_yesButton.bottomAnchor.constraint(equalTo: n_background.bottomAnchor, constant: -20/895*viewHeight),
            n_yesButton.leadingAnchor.constraint(equalTo: n_background.leadingAnchor, constant: 20/895*viewHeight),
            n_yesButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            n_yesButton.trailingAnchor.constraint(equalTo: n_background.centerXAnchor, constant: -20/895/2*viewHeight)
            ])
        
        n_noButton = UIButton()
        n_noButton.translatesAutoresizingMaskIntoConstraints = false
        n_noButton.backgroundColor = UIColor.clear
        n_noButton.setTitleColor(UIColor.white, for: .normal)
        n_noButton.layer.cornerRadius = 8
        n_noButton.layer.masksToBounds = true
        n_noButton.addTarget(self, action:#selector(delete(sender:)), for: .touchDown)
        n_noButton.setTitle("No", for: .normal)
        n_noButton.titleLabel?.font = UIFont.systemFont(ofSize: 25/895*viewHeight, weight: .light)
        n_noButton.titleLabel?.textAlignment = .center
        n_noButton.layer.borderColor = UIColor.white.cgColor
        n_noButton.layer.borderWidth = 1
        view.addSubview(n_noButton)
        n_noButton.isHidden = true
        NSLayoutConstraint.activate([
            n_noButton.bottomAnchor.constraint(equalTo: n_background.bottomAnchor, constant: -20/895*viewHeight),
            n_noButton.trailingAnchor.constraint(equalTo: n_background.trailingAnchor, constant: -20/895*viewHeight),
            n_noButton.heightAnchor.constraint(equalToConstant: 35/895*viewHeight),
            n_noButton.leadingAnchor.constraint(equalTo: n_background.centerXAnchor, constant: 20/895/2*viewHeight)
            ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: (174-211)/895*viewHeight),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -8/414*viewWidth),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: viewWidth)
            ])
        NSLayoutConstraint.activate([
            rec.heightAnchor.constraint(equalToConstant: 39/895*viewHeight),
            rec.widthAnchor.constraint(equalToConstant: 126/414*viewWidth),
            rec.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rec.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20/895*viewHeight)
            ])
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 39/895*viewHeight),
            addButton.widthAnchor.constraint(equalToConstant: 126/414*viewWidth),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20/895*viewHeight)
            ])
        NSLayoutConstraint.activate([
            plusSign.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            plusSign.centerYAnchor.constraint(equalTo: addButton.centerYAnchor, constant: -2/895*viewHeight)
            ])
        NSLayoutConstraint.activate([
            createView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createView.widthAnchor.constraint(equalToConstant: 4/5*viewWidth),
            createView.heightAnchor.constraint(equalToConstant: 4/5*viewWidth)
            ])
    }
    
    /******************************** MARK: Action Functions ********************************/
    
    @objc func add() {
        createView.d_name.text = "New Goal"
        createView.d_date.setTitle(dateFormatter.string(from: Date(timeIntervalSinceNow: 60*60*24+1)), for: .normal)
        createView.date = Date(timeIntervalSinceNow: 60*60*24+1)
        createView.d_description.text = "Enter a description of what you want to accomplish, and why you want to achieve this goal."
        createView.isHidden = false
        addButton.isEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = false
        blurView.isHidden = false
    }
    
    /******************************** MARK: UICollectionView: Data Source ********************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selected_goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalCellIdentifier, for: indexPath) as! GoalCVC
        let goal = selected_goals[indexPath.row]
        cell.configure(for: goal)
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(delete(sender:)))
//        swipe.direction = UISwipeGestureRecognizerDirection.left
//        cell.addGestureRecognizer(swipe)
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
        self.delegateShowDetail?.presentDetail(detailController: detailView)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (414 - 17 - 33)/414*viewWidth
        return CGSize(width: w, height: w/(364/148))
    }
    
    
    
    /******************************** MARK: UITableView: Delete Cell ********************************/
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        n_nameLabel.text = goals[indexPath.item].name
        n_background.isHidden = false
        n_label.isHidden = false
        n_nameLabel.isHidden = false
        n_yesButton.isHidden = false
        n_noButton.isHidden = false
        addButton.isEnabled = false
        blurView.isHidden = false
        collectionView.isUserInteractionEnabled = false
        deleteIndex = indexPath
    }
    @objc func delete(sender: UIButton) {
        if (sender == n_yesButton) {
            self.delegate?.addedEvent(title: "goal \"\(goals[(deleteIndex?.item)!].name)\" deleted", date: Date())
            goals.remove(at: (deleteIndex?.item)!)
            selected_goals = goals
            collectionView.deleteItems(at: [deleteIndex!])
        }
        if (sender == n_noButton) {
            collectionView.reloadData()
        }
        deleteIndex = nil
        n_background.isHidden = true
        n_label.isHidden = true
        n_nameLabel.isHidden = true
        n_yesButton.isHidden = true
        n_noButton.isHidden = true
        addButton.isEnabled = true
        collectionView.isUserInteractionEnabled = true
        blurView.isHidden = true
        
    }
    
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
    
    func animateHeader() {
        self.headerHeightConstraint.constant = 211/895*viewHeight
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
}

/******************************** MARK: Navigation Bar Customization ********************************/
/******************************** MARK: Sticky Header ********************************/
extension HomeView: UIScrollViewDelegate {
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

extension HomeView: createGoal {
    func createdGoal(newGoal: Goal) {
        goals.append(newGoal)
        selected_goals = goals
        collectionView.reloadData()
        collectionView.scrollToItem(at: NSIndexPath(row: goals.count-1, section: 0) as IndexPath, at: .bottom, animated: true)
        //self.delegate?.addGoal(newGoal: newGoal)
        self.delegate?.addedEvent(title: "goal \"\(newGoal.name)\" set", date: Date())
        createView.isHidden = true
        addButton.isEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        blurView.isHidden = true
    }
    func cancelCreate() {
        createView.isHidden = true
        addButton.isEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        blurView.isHidden = true
    }
    func showCreationAlert() {
        self.present(alert, animated: true)
    }
    
}


