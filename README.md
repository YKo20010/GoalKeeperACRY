# GoalKeeper
Created by: <i>Yanlam Ko (iOS), Avani Aggrwal (iOS), Richard Wang (Backend)</i> | Designed by: <i>Cecilia Lu</i>

<strong> Set goals for yourself, mark and track your progress. </strong> 

<p>GoalKeeper is an app that is designed to help the user track their goals.</p> 
<p>The user first starts off by logging in through a Google account, after which they are greeted by their name. The home screen in the app allows users to add goals for themselves by setting a name, potential date of completion, and a description for motivation. When a goal is clicked on, a detail screen is brought up that is specific to the goal. This detail view allows the user to add and delete checkpoints, edit the goal, view which checkpoints are completed, and the date that they were completed. This screen also gives users the option to check off checkpoints. Once the user has met all checkpoints, a button for completing the goal appears.</p>
<p>GoalKeeper also provides a calendar screen (linked to the phone's calendar) that allows users to see when their goals have been made or met, a progress screen, which provides a visual documentation of the progress of each goal, a history screen, to scroll through and search completed goals, and a profile screen, on which the user can log out of their Google account and view the number of current and completed goals.</p>

#### Login, Loading, and Profile Screens:
<img src="App%20Screenshots/screenshots/Login.png" width="207" height="447.5"> <img src="App%20Screenshots/LoginScreen.png" width="207" height="447.5"> <img src="App%20Screenshots/WelcomeScreen.png" width="207" height="447.5"> <img src="App%20Screenshots/ProfileView.png" width="207" height="447.5">

#### Home Screen: Goals Display, Create/Delete Goals:
<img src="App%20Screenshots/screenshots/home.png" width="207" height="447.5"> <img src="App%20Screenshots/MakeGoal.png" width="207" height="447.5"> <img src="App%20Screenshots/screenshots/AddGoal.png" width="207" height="447.5"> <img src= "App%20Screenshots/screenshots/DeleteGoal.png" width="207" height="447.5">

#### Goal Detail: Checkpoints, Motivation, Checkpoint Creation, Goal Editing:
<img src="App%20Screenshots/screenshots/detail.png" width="207" height="447.5"> <img src="App%20Screenshots/CompleteCheckpoints.png" width="207" height="447.5"> <img src="App%20Screenshots/screenshots/NewCheckpoint.png" width="207" height="447.5"> <img src="App%20Screenshots/screenshots/EditGoal.png" width="207" height="447.5">

#### Calendar, Visual Progress Bars, History, and History Search:
<img src="App%20Screenshots/CalendarView.png" width="207" height="447.5"> <img src="App%20Screenshots/ProgressView.png" width="207" height="447.5"> <img src="App%20Screenshots/screenshots/History.png" width="207" height="447.5"> <img src="App%20Screenshots/screenshots/HistorySearch.png" width="207" height="447.5">

### iOS:

&#10141; NSLayoutConstraint used to place views as per the design, and fit multiple screen dimensions.

&#10141; UICollectionView implemented in HomeView, DetailView, and EventsView to display goals, checkpoints, motivation, and key dates. UITableView implemented in ProgressView and HistoryView to present current and completed goals. UITableView embedded in CollectionViewCell to list checkpoints of a specific goal within the DetailView.

&#10141; UITabBarController displayed at bottom of main ViewControllers with icons for each screen, and ability to navigate between screens. User is brought to their desired page upon click of an icon.

&#10141;GoogleSignIn API implemented to greet users by their first name. User's data filtered through the connection to their Google accounts. Goals API (http://35.196.246.200/api/goals/), created by Richard Wang (backend), stores UI configured goal/checkpoint changes.

&#10141;Note: ProgressView displays percentage of <i>entire</i> goal reached -- in calculations, the weight of completing the actual goal is identical to the weight of each checkpoint

### Backend:

&#10141; [SQLAlchemy](https://www.sqlalchemy.org/) - The ORM used

&#10141; [Flask](http://flask.pocoo.org/) - Web framework

&#10141; [Docker](https://www.docker.com/) - Containerization

&#10141; [Google Cloud](https://cloud.google.com/) - Server hosting

&#10141; a link to the full API Spec can be found [here](https://paper.dropbox.com/doc/GoalKeeper-API-Spec--AS7PspOfFNUfAe53Jn032H6qAg-CrsHYKwhBpOZc3oiUL6pb)

### Authors:

&#10141; [Yanlam Ko](https://github.com/YKo20010)

&#10141; [Avani Aggrwal](https://github.com/avaniaggrwal)

&#10141; [Richard Wang](https://github.com/richardlwang)




<p>&#169;2018 by A.C.R.Y.</p>
