//
//  CalendarView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit
import EventKit
import KDCalendar

protocol addEvent: class {
    func addedEvent(title: String, date: Date)
}

class EventsView: UIViewController, CalendarViewDelegate, CalendarViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var headerView: calendarHeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    var scrollview: UIScrollView!
    var subheaderView: subHeader!
    var subheaderHeightConstraint: NSLayoutConstraint!
    
    var collectionView: UICollectionView!
    var goals: [Goal] = []
    var keyEvents: [CalendarEvent] = []
    var dateLabelText: String = ""
    let goalCellIdentifier = "goalCellIdentifier"
    
    var calendarView: CalendarView!
    var label: UILabel!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        
        /*  TODO: Network and delete this   */
        let c1 = Checkpoint(name: "Checkpoint1", date: Date(), isFinished: false, startDate: Date())
        let c2 = Checkpoint(name: "Checkpoint2", date: Date(), isFinished: false, startDate: Date())
        let c3 = Checkpoint(name: "Checkpoint3", date: Date(), isFinished: true, startDate: Date())
        let c4 = Checkpoint(name: "Checkpoint4", date: Date(), isFinished: true, startDate: Date())
        
        let g1 = Goal(name: "0/0", date: Date(timeInterval: 5256000, since: Date()), description: "description text 1", checkpoints: [], progress: 0, startDate: Date())
        let g2 = Goal(name: "1/1", date: Date(timeInterval: 13140000, since: Date()), description: "description text 2", checkpoints: [c4], progress: 50, startDate: Date())
        let g3 = Goal(name: "0/1", date: Date(timeInterval: 60*60*24*27+1, since: Date()), description: "text3", checkpoints: [c1], progress: 25, startDate: Date())
        let g4 = Goal(name: "0/2", date: Date(timeInterval: 60*60*24*1+1, since: Date()), description: "text4", checkpoints: [c1, c2], progress: 77, startDate: Date())
        let g5 = Goal(name: "1/3", date: Date(timeInterval: 31540000+1, since: Date()), description: "text5", checkpoints: [c1, c2, c3], progress: 33, startDate: Date())
        let g6 = Goal(name: "2/4", date: Date(timeInterval: 60*60*24*365*10+1, since: Date()), description: "text6", checkpoints: [c1, c2, c3, c4], progress: 100, startDate: Date())
        goals = [g1, g2, g3, g4, g5, g6]
        
        headerView = calendarHeaderView(frame: .zero, textSize: 40/895*viewHeight, viewHeight: viewHeight)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 127/895*viewHeight)
        headerHeightConstraint.isActive = true
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        CalendarView.Style.cellShape                = .round
        CalendarView.Style.cellColorDefault         = UIColor.white
        CalendarView.Style.cellColorToday           = UIColor(red: 201/255, green: 142/255, blue:25/255, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red: 212/255, green: 114/255, blue: 114/255, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red: 212/255, green: 114/255, blue: 114/255, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1.0)
        CalendarView.Style.cellTextColorDefault     = UIColor.black
        CalendarView.Style.cellTextColorToday       = UIColor.white
        CalendarView.Style.firstWeekday = .sunday
            
        setupCalendar()
        
        subheaderView = subHeader(frame: .zero, viewWidth: viewWidth, viewHeight: viewHeight)
        subheaderView.translatesAutoresizingMaskIntoConstraints = false
        subheaderHeightConstraint = subheaderView.heightAnchor.constraint(equalToConstant: 64/895*viewHeight)
        subheaderHeightConstraint.isActive = true
        view.addSubview(subheaderView)
        NSLayoutConstraint.activate([
            subheaderView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20/895*viewHeight),
            subheaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subheaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10/895*viewHeight
        //layout.estimatedItemSize = CGSize(width: viewWidth, height: viewWidth/2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyDatesCVC.self, forCellWithReuseIdentifier: goalCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subheaderView.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: viewWidth)
            ])
        }
    
        private func setupCalendar() {
            calendarView = CalendarView()
            calendarView.backgroundColor = UIColor.white
            calendarView.translatesAutoresizingMaskIntoConstraints = false
            calendarView.direction = .horizontal
            calendarView.marksWeekends = false
            calendarView.dataSource = self
            calendarView.delegate = self
            calendarView.multipleSelectionEnable = false
            view.addSubview(calendarView)
            NSLayoutConstraint.activate([
                calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20/895*viewHeight),
                calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20/895*viewHeight),
                calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20/895*viewHeight),
                calendarView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -40/895*viewHeight)
                ])
        }
    
    /************************** MARK: CalendarView: Delegate & Data Source **************************/
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return threeMonthsAgo!
    }
        
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2;
        let today = Date()
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return twoYearsFromNow
    }
        
    func addEvent(_ title: String, date: Date, duration hours: NSInteger = 1) -> Bool {
            return false
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
            return true
    }
        
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
    }
        
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
        print("Did Select: \(date) with \(events.count) events")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MM/dd"
        let dateShow = Date(timeInterval: 60*60*24 + 1, since: date)
        dateLabelText = dateFormatter.string(from: dateShow)
        
        keyEvents = events
        collectionView.reloadData()
    }
        
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        dateLabelText = ""
        keyEvents = []
        collectionView.reloadData()
    }
        
    func calendar(_ calendar: CalendarView, didLongPressDate date : Date) {
//
//        let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)
//
//        alert.addTextField { (textField: UITextField) in
//            textField.placeholder = "Event Title"
//        }
//
//        let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
//            let title = alert.textFields?.first?.text
//            self.calendarView.addEvent(title!, date: date)
//        })
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
//
//        alert.addAction(addEventAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true, completion: nil)
        
    }
        
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: false)
            
        self.calendarView.loadEvents() { error in
            if error != nil {
                let message = "The karmadust calender could not load system events. It is possibly a problem with permissions"
                let alert = UIAlertController(title: "Events Loading Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    /************************** MARK: UICollectionView: Data Source **************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (keyEvents.count == 0) {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goalCellIdentifier, for: indexPath) as! KeyDatesCVC
        cell.dateLabel.text = dateLabelText
        cell.notes = []
        for event in keyEvents {
            cell.notes.append("\(event.title)")
        }
        cell.tableView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = viewWidth!
        let h = CGFloat(keyEvents.count + 1)*60/414*viewWidth!
        return CGSize(width: w, height: h)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}

extension EventsView: addEvent {
    func addedEvent(title: String, date: Date) {
        calendarView.addEvent(title, date: date)
        calendarView.deselectDate(date)
        collectionView.reloadData()
    }
}


