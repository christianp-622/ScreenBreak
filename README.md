# ScreenBreak
ScreenBreak is your all in one place to gain insights and set sheids for the applicaitons on your device.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Frameworks and Extensions](#frameworkds-and-extensions)
3. [Package Dependencies](#package-dependencies)
4. [Files](#files)
5. [Demo](#demo)
6. [Acknowledgment](#acknowledgment)
7. [Roadmap](#roadmap)


## Project Overview
The goal of this project is to utilize the Screentime API (DeviceActivity, ManagedSettings, 
FamilyControls) to provide users with insights on the apps they use. With the announcement 
at WWDC22, individual authorization to set shields on apps is now possible, allowing users 
to have control over their own usage. In this application, authorization is invoked via the 
AuthorizationCenter in the FamilyControls App Service as soon as the application is launched.

## Frameworks and Extensions

### SwiftUI
We utilize the SwiftUI framework, which provides a modern and intuitive way to create a 
visually pleasing user interface.

### Device Acitivity Report Extension
We make use of the Device Activity Report Extension to retrieve insights on an individual 
user's device activity. Each application on the user's device is represented by an ActivityToken, 
while each category is represented by a CategoryToken. Additionally, Web DomainTokens represent 
web domains. The insights obtained include:
* Number of notifications per applcation
* Number of pickups per application
* Category for a given application
* Screen time per applciation/category
* The time at which a user had their first device pickup of the day

### Family Controls
The FamilyControls App Service allows us to utilize a FamilyActivityPicker, which displays a 
list of all the applications, categories, and web domains on a user's device. Users can choose 
any number of items from the list, and a viewModel is created to save those selections as a 
FamilyActivitySelection. The saved selection enables us to set shields on the chosen items 
and lift those shields as well.

### Device Activity Monitor Extension
The Device Activity Monitor enables us to lift a shield, allowing us to create multiple shield 
time intervals instead of a singular option. 

### Sheild Cofiguration Extension
This extension allows us to create a custom shield with our logo and personalized message on it.

### Widget Extension
The Widget Extension allows us to create a custom widget for our application. According to Apple's 
guidelines, the widget should provide glanceable information and stay up to date with your application. 
Our widget shows whether the user is in restriction mode or not, and displays the time at which their 
restriction mode will be lifted (if they are in restriction mode). To enable communication between the 
extension and the main app, we created an app group, providing a line of communication between the 
widget and the main app.


## Package Dependencies

#### RiveRuntime
RiveRuntime enables us to implement an animated navigation bar for seamless navigation throughout our app.
Additionally, it provides a beautifully animated background for our onboarding screen. We chose Rive assets 
over Lottie assets due to their smaller size.

#### SwiftUICharts
We use SwiftUICharts to properly display the data gathered from the Device Activity Report. The charts 
are animated, offer various color schemes, and adapt to light and dark mode. Users can interact with 
the charts to explore the data.


## Files

- **/ScreenBreak**: Contains the source code files of the iOS app.

  - `ScreenBreakApp.swift`: Main app file. Initializes all environment objects and invokes the launch screen.

  - **/RiveAssets**: Contains rive asset files
  - **/Views**: Contains all the views for the application
    - `HomeView.swift`: 
    - `ContentView.swift`: 

- **/RiveAssets**: Contains rive asset files
    
- **/ReportExtension**: 
  - `ReportExtension.swift`: 
  - `TotalAcitivtyReport.swift`: 
  - `TotalActivityView.swift`: 
  - `TopAppsReport.swift`: 
  - `TopThreeView.swift`: 
  - `HomeReport.swift`: 
  - `HomeReportView.swift`: 
  - `WidgetReport.swift`: 
  - `WidgetReportView.swift`: 
  - `TotalPickupsReport.swift`: 
  - `PickypsChartView.swift`: 
  - `CardView.swift`: View that formats an applciation icon and it's name into a structured view
  - `AppDeviceActivity.swift`: Defines the models for the device activity report
- **/DeviceActivityMonitor**: 
  - `DeviceActivityMonitorExtension.swift`:
- **/shield**: 
  - `ShieldConfigurationExtension.swift`:
  - `sblogosmall.png`:
- **/SBWidget**: 
  - `SBWidget.swift`:

 

## Demo

## Acknowledgment
Special thanks to:
DesignCode Youtube for the 3-hour tutorial with Rive Animations, custom fonts, as well as a provided 
codebase - https://www.youtube.com/watch?v=h4vyOz4Tztg&t=2878s

## Roadmap
For future iterations of this project, we want to implement a couple of things:
