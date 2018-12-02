# GoalKeeper &#169;2018 by A.C.R.Y.
<strong> Set goals for yourself, mark and track your progress. </strong> 

Created by: <i>Yanlam Ko (iOS), Avani Aggrwal (iOS), Richard Wang (Backend)</i> | Designed by: <i>Cecilia Lu</i>

<p>GoalKeeper is an app that is designed to help the user track their goals.</p> 
<p>The user first starts off by logging in through a Google account, after which they are greeted by their name. The home screen in the app allows users to add goals for themselves by setting a name, potential date of completion, and a description for motivation. When a goal is clicked on, a detail screen is brought up that is specific to the goal. This detail view allows the user to add and delete checkpoints, edit the goal, view which checkpoints are completed, and the date that they were completed. This screen also gives users the option to check off checkpoints. Once the user has met all checkpoints, a button for completing the goal appears.</p>
<p>GoalKeeper also provides a calendar screen (linked to the phone's calendar) that allows users to see when their goals have been made or met, a progress screen, which provides a visual documentation of the progress of each goal, a history screen, to scroll through and search completed goals, and a profile screen, on which the user can log out of their Google account and view the number of current and completed goals.</p>

<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/LoginView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/LoadView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/HomeView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/DeleteView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/CalendarView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/CalendarView2.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/ProgressView.png" width="207" height="447.5" />

iOS:

&#10141; NSLayoutConstraint used to place views as per the design, and fit multiple screen dimensions.

&#10141; UICollectionView implemented in HomeView, DetailView, and EventsView to display goals, checkpoints, motivation, and key dates. UITableView implemented in ProgressView and HistoryView to present current and completed goals. UITableView embedded in CollectionViewCell to list checkpoints of a specific goal within the DetailView.

&#10141; UITabBarController displayed at bottom of main ViewControllers with icons for each screen, and ability to navigate between screens. User is brought to their desired page upon click of an icon.

&#10141; GoogleSignIn API implemented to greet users by their first name. User's data filtered through the connection to their Google accounts. Goals API (http://35.196.246.200/api/goals/), created by Richard Wang (backend), stores UI configured goal/checkpoint changes.

Backend:

<p>Note: ProgressView displays percentage of <i>entire</i> goal reached -- in calculations, the weight of completing the actual goal is identical to the weight of each checkpoint</p>

