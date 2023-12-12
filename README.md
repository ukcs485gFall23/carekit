<!--
Name of your final project
-->
# Geek's APP
![Swift](https://img.shields.io/badge/swift-5.5-brightgreen.svg) ![Xcode 13.2+](https://img.shields.io/badge/xcode-13.2%2B-blue.svg) ![iOS 15.0+](https://img.shields.io/badge/iOS-15.0%2B-blue.svg) ![watchOS 8.0+](https://img.shields.io/badge/watchOS-8.0%2B-blue.svg) ![CareKit 2.1+](https://img.shields.io/badge/CareKit-2.1%2B-red.svg) ![ci](https://github.com/netreconlab/CareKitSample-ParseCareKit/workflows/ci/badge.svg?branch=main)

## Description
<!--
Give a short description on what your project accomplishes and what tools is uses. Basically, what problems does it solve and why it's different from other apps in the app store.
-->
An example application of [CareKit](https://github.com/carekit-apple/CareKit)'s OCKSample synchronizing CareKit data to the Cloud via [ParseCareKit](https://github.com/netreconlab/ParseCareKit).

Geek-App is a CareKit-based health app designed specifically for computer programmers. It helps programmers to improve their physical and mental health by providing personalized recommendations, tracking their progress, and connecting them with a community of other programmers who are also working to improve their health.



### Demo Video
<!--
Add the public link to your YouTube or video posted elsewhere.
-->
To learn more about this application, watch the video below:

<a href="https://www.youtube.com/watch?feature=player_embedded&v=5tL2P1MByJI" target="_blank"><img src="http://img.youtube.com/vi/5tL2P1MByJI/0.jpg" 
alt="Sample demo video" width="240" height="180" border="10" /></a>

### Designed for the following users
<!--
Describe the types of users your app is designed for and who will benefit from your app.
-->
Geek-App is for computer programmers who are concerned about their health and want to take steps to improve it. The app can benefit users in a number of ways, including:

Improved physical health: Geek-App can help users to improve their physical health by providing personalized recommendations for exercise, nutrition, and sleep. The app can also track users' progress and help them to identify areas where they can improve.
Improved mental health: Geek-App can help users to improve their mental health by providing them with a community of other programmers who are also working to improve their health. The app also includes features such as stress management and mood tracking.
Increased motivation: Geek-App can help users to stay motivated by providing them with personalized goals, tracking their progress, and rewarding them for their achievements.
<!--
In addition, you can drop screenshots directly into your README file to add them to your README. Take these from your presentations.
-->


![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 15 16](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/fa05bc15-d595-466a-8dbc-e0f43038ff72 | width=300)
![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 15 16](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/fa05bc15-d595-466a-8dbc-e0f43038ff72 | width=300)
![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 21 45](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/1d4d4db9-6c12-49bb-ab87-15a2fdc21db2 | width=300)
![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 22 33](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/22907d35-0714-4d1c-8bba-a6fb74bdc6f4 | width=300)
![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 32 28](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/cb92106f-9453-49aa-ada1-0c8fbdaa7464 | width=300)
![Simulator Screenshot - iPhone 15 Pro - 2023-12-12 at 10 44 08](https://github.com/ukcs485gFall23/final-akwaed/assets/37512610/0ccf43ba-4e7f-4f62-95cc-db7313c6fbc3 | width=300)

<!--
List all of the members who developed the project and
link to each members respective GitHub profile
-->
Developed by: 
- [Dr. Corey Baker](https://github.com/cbaker6) - `University of Kentucky`, `Computer Science Professor`
- [Elnoel Akwa](https://github.com/akwaed) - `University of Kentucky`, `Computer Engineering`

ParseCareKit synchronizes the following entities to Parse tables/classes using [Parse-Swift](https://github.com/parse-community/Parse-Swift):

- [x] OCKTask <-> Task
- [x] OCKHealthKitTask <-> HealthKitTask 
- [x] OCKOutcome <-> Outcome
- [x] OCKRevisionRecord.KnowledgeVector <-> Clock
- [x] OCKPatient <-> Patient
- [x] OCKCarePlan <-> CarePlan
- [x] OCKContact <-> Contact

**Use at your own risk. There is no promise that this is HIPAA compliant and we are not responsible for any mishandling of your data**

<!--
What features were added by you, this should be descriptions of features added from the [Code](https://uk.instructure.com/courses/2030626/assignments/11151475) and [Demo](https://uk.instructure.com/courses/2030626/assignments/11151413) parts of the final. Feel free to add any figures that may help describe a feature. Note that there should be information here about how the OCKTask/OCKHealthTask's and OCKCarePlan's you added pertain to your app.
-->
## Contributions/Features
On the insights tab, there are 3 surveys that pertain to a user's taks and their related outcomes. Two of these graphs pertain to a user's response on built-in surveys that address a user's sleep as well as a user's opinion of their productivity levels. The third graph is a representation of the amount of alchool vs water they consume each week. OCKHealthKitTasks are also built into the application's funcitonality and pull data from the Health app on a user's phone to display current moveTime, standTime and alchool intake information. I have also created two new custom button types, the first of which is intended to let the user keep track of how much alchool they drink. The second custom button type is a text input feature designed to be a give the users puns to start their day happy. There is also added functionality to the profile tab, with the user having the ability to add their own custom OCKTasks and OCKHealthKitTasks, as well as being able to update their own profile and contact information.
## Final Checklist
<!--
This is from the checkist from the final [Code](https://uk.instructure.com/courses/2030626/assignments/11151475). You should mark completed items with an x and leave non-completed items empty
-->
- [x] Signup/Login screen tailored to app
- [x] Signup/Login with email address
- [x] Custom app logo
- [x] Custom styling
- [x] Add at least **5 new OCKTask/OCKHealthKitTasks** to your app
  - [x] Have a minimum of 7 OCKTask/OCKHealthKitTasks in your app
  - [x] 3/7 of OCKTasks should have different OCKSchedules than what's in the original app
- [x] Use at least 5/7 card below in your app
  - [x] InstructionsTaskView - typically used with a OCKTask
  - [x] SimpleTaskView - typically used with a OCKTask
  - [x] Checklist - typically used with a OCKTask
  - [x] Button Log - typically used with a OCKTask
  - [ ] GridTaskView - typically used with a OCKTask
  - [x] NumericProgressTaskView (SwiftUI) - typically used with a OCKHealthKitTask
  - [x] LabeledValueTaskView (SwiftUI) - typically used with a OCKHealthKitTask
- [x] Add the LinkView (SwiftUI) card to your app
- [x] Replace the current TipView with a class with CustomFeaturedContentView that subclasses OCKFeaturedContentView. This card should have an initializer which takes any link
- [x] Tailor the ResearchKit Onboarding to reflect your application
- [x] Add tailored check-in ResearchKit survey to your app
- [x] Add a new tab called "Insights" to MainTabView
- [x] Replace current ContactView with Searchable contact view
- [x] Change the ProfileView to use a Form view
- [x] Add at least two OCKCarePlan's and tie them to their respective OCKTask's and OCContact's 

## Wishlist features
<!--
Describe at least 3 features you want to add in the future before releasing your app in the app-store
-->
1. 3rd party api to connect with forum based app like reddit and qoura
2. Social features for friendly competition
3. Ability to delete tasks
4. Ability to import images into tasks
5. allow user to set goals on the app

## Challenges faced while developing
<!--
Describe any challenges you faced with learning Swift, your baseline app, or adding features. You can describe how you overcame them.
-->
The biggest problem I faced during development, was  navigating documentation related to problems I was experiencing. Often I would run into issues and searched possible fixes but often times Apple's documentation links were bad and there was a not of information pertaining to the situation I was in. Also, tGetting the healthcareLinkage app to preview on my default screen seemed to be and issue

## Setup Your Parse Server

### Heroku
The easiest way to setup your server is using the [one-button-click](https://github.com/netreconlab/parse-hipaa#heroku) deplyment method for [parse-hipaa](https://github.com/netreconlab/parse-hipaa).


## View your data in Parse Dashboard

### Heroku
The easiest way to setup your dashboard is using the [one-button-click](https://github.com/netreconlab/parse-hipaa-dashboard#heroku) deplyment method for [parse-hipaa-dashboard](https://github.com/netreconlab/parse-hipaa-dashboard).
