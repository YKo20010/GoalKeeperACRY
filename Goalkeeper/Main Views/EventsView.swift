//
//  CalendarView.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

//Calendar gets events from Apple Calendar (EventKit), not linked to Google Sign-In

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
    let goalCellIdentifier = "keydatesCellIdentifier"
    
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
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyDatesCVC.self, forCellWithReuseIdentifier: goalCellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
        view.addSubview(collectionView)
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: subheaderView.bottomAnchor, constant: 10/895*viewHeight),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10/895*viewHeight),
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
                calendarView.heightAnchor.constraint(equalToConstant: 373/895*viewHeight)
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
        let dateShow = date
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
        let h = CGFloat(keyEvents.count)*20/414*viewWidth! + 34/414*viewWidth! + 21/414*viewWidth!
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


