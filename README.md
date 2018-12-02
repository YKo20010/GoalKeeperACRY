# GoalKeeperACRY
Cornell AppDev Hack Challenge | 
Avani Aggrwal: iOS | 
Cecilia Lu: Design | 
Richard Wang: Backend | 
Yanlam Ko: iOS


App Name: GoalKeeper 

Set goals for yourself, mark and track your progress.


<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/LoginView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/LoadView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/HomeView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/DeleteView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/CalendarView.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/CalendarView2.png" width="207" height="447.5" />
<img src="https://github.com/YKo20010/GoalKeeperACRY/blob/master/screenshots/ProgressView.png" width="207" height="447.5" />


GoalKeeper is an app that is designed to help the user track their goals. The user firsts starts off by logging in through a Google account, after which they are greeted by their name. The home screen in the app allows users to add goals for themselves by setting a name, potential date of completion, and checkpoints for each goal. When each goal is clicked on, a new screen is brought up that is specific to the goal. This new screen lists details about the goals, such as which of the checkpoints are completed and the date that they were completed. This screen also gives users the option to check off checkpoints and list a motivation for themselves for completing this goal. We have also provided a calendar screen that allows users to see when their goals should be completed on a big calendar. Another screen is a progress screen, which provides a visual documentation of the progress of each goal. A progress bar is displayed for the goals on this screen. Finally, our last screen, is a profile screen, on which the user can log out of their Google account and view how many goals they have completed. 

Requirements addressed in our app:

iOS Requirements:

-Autolayout is used with NSLayoutConstraint. Every screen on our app has parts that were put together on the screen using constraints, which we needed NSLayoutConstraint for. NSLayoutConstraint was used to make sure that every item that we had on the screen was put in the place that our design showed it to be in.

-We used both UICollectionViews and UITableViews. For example, our HomeView screen contains a UICollectionView to show a list of the user's goals, and some information about these goals. Additionally, on the DetailView screen, a UICollectionView is used to present the checkpoints and the motivation panels. A UITableView is embedded within cell for the checkpoints on this screen in order to list out all of the checkpoints and give the user the option to check them off as completed.

-We used a UITabBarController to navigate between screens. At the bottom of each screen, a tab bar displaying icons for each screen is displayed. By clicking on any of the icons, the user will be brought to their desired page.

-In this app, we used two APIs. First, we used the Google sign in API. This allows the user to be greeted by name by the app. Additionally, the user's data can be saved by connecting it to their Google accounts. We also used an API created by our team's backend member, Richard. This API takes in user data and updates the API with this data. 

Backend Requirements:

