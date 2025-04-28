# ScreenBreak
<p align="left">
  <img src="ScreenBreak/ScreenBreak/Assets.xcassets/appLogo.imageset/ScreenBreakBlack.png" alt="Project Logo" width="150" height="150">
</p>
ScreenBreak offers advanced ScreenTime restrictions and monitoring. This project explores the 
capabilites of the iOS 16 Screen Time API.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Frameworks and Extensions](#frameworks-and-extensions)
3. [Package Dependencies](#package-dependencies)
4. [Demo](#demo)
5. [Acknowledgment](#acknowledgment)
6. [Roadmap](#roadmap)


## Project Overview
The goal of this project was to leverage Apple’s Screen Time APIs (DeviceActivity, ManagedSettings, FamilyControls) to give users two capabilities:
- Usage insights – clear, daily analytics on which apps and categories consume the most time.
- Self-lock – let users “shield” any app for a user-defined interval, helping them stay accountable and reduce distractions.

On first launch, the app requests the necessary privileges through AuthorizationCenter (FamilyControls) so each user can grant personal control—made possible by new individual-authorization rules introduced at WWDC 22.

## Frameworks and Extensions

#### *SwiftUI*   
We utilize the SwiftUI framework, which provides a modern and intuitive way to create a 
visually pleasing user interface.  
<br>

#### *Device Acitivity Report Extension*

Retrieves per-user analytics by mapping:

| Token Type  | Represents |
| ------------- | ------------- |
| ActivityToken  | A single app  |
| CategoryToken  | An Apple-defined category (e.g., Social, Productivity) |
| WebDomainToken  | A specific web domain  |

Captured metrics include:

- Notification count per app
- Pick-up count per app (times the device is woken)
- Category for each app or domain
- Screen-time totals per app and per category
- Time of first pick-up each day
<br>

#### *Family Controls*
Leveraged the FamilyActivityPicker (from FamilyControls) to present users with a complete list of apps, categories, and web domains installed on their device. The flow is:
- User selects items in the picker (multiple choice).
- A view-model converts those choices into a persisted FamilyActivitySelection.

The stored selection is used by the Managed Settings layer to
• apply shields—temporarily blocking the chosen apps, categories, or domains, and
• lift shields on demand or when the timer expires.

This pattern cleanly separates UI, state management, and policy enforcement while giving users granular control over their own distractions.
<br>

#### *Device Activity Monitor Extension*
The Device Activity Monitor enables us to lift a shield, allowing us to create multiple shield 
time intervals instead of a singular option.   
<br>

#### *Sheild Cofiguration Extension*
This extension allows us to create a custom shield with our logo and personalized message on it.  
<br>

#### *Widget Extension*
The Widget Extension allows us to create a custom widget for our application. According to Apple's 
guidelines, the widget should provide glanceable information and stay up to date with your application. 
Our widget shows whether the user is in restriction mode or not, and displays the time at which their 
restriction mode will be lifted (if they are in restriction mode). To enable communication between the 
extension and the main app, we created an app group, providing a line of communication between the 
widget and the main app.  
<br>

## Package Dependencies

#### *RiveRuntime*
RiveRuntime enables us to implement an animated navigation bar for seamless navigation throughout our app.
Additionally, it provides a beautifully animated background for our onboarding screen. We chose Rive assets 
over Lottie assets due to their smaller size.  
<br>

#### *SwiftUICharts*
We use SwiftUICharts to properly display the data gathered from the Device Activity Report. The charts 
are animated, offer various color schemes, and adapt to light and dark mode. Users can interact with 
the charts to explore the data.  
<br>

## Demo

#### Launch Screen
<img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/79debd98-d4e7-4a4e-9f8c-b9c1bd325597" alt= "Animated GIF"
    width="200" height="450">
    
#### Onboarding Screen (Light Mode)
<img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/3dea6fdf-6d45-4629-bb2f-065e212bc5f1" alt="Animated GIF"     width="200" height="450">

#### Home Screen
 <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/659a5501-86c4-4d38-aaef-2b6dc9f1af89" alt= "Animated GIF"
    width="200" height="450">
    
#### Screen Time View
<p float="left">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/44f8a661-7cd4-4a19-938a-c0a37fa1c84d" alt= "Animated GIF"
    width="200" height="450">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/165e0cb3-55aa-4dc2-9b79-a87fa8010669" alt= "Animated GIF"
    width="200" height="450">
</p>

#### Restrictions Screen
<p float="left">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/04462a0a-4736-40a9-80c3-8819d18daf81" alt= "Animated GIF"
    width="200" height="450">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/3025eec3-dac8-4a86-9b6f-44e65a1a3783" alt= "Animated GIF"
    width="200" height="450">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/f522f2e9-a96a-45af-b7e9-2bd24a8077cf" alt= "Animated GIF"
    width="200" height="450">
</p>

#### Custom Sheild
<img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/6bf29e3f-cab9-4e03-86fb-68a8af805faa" alt= "Animated GIF"
    width="200" height="450">

#### More Insights Screen 
<img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/e02d9886-fad0-42ea-b226-7fafff0b49ae" alt= "Animated GIF"
    width="200" height="450">
    
#### Widget
<p float="left">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/eeb61be1-f3e7-4bf1-ad5f-447228d40734" alt= "Animated GIF"              width="200" height="450">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/76c8bd64-4173-4460-804c-dfb73c9806ef" alt= "Animated GIF"              width="200" height="450">
  <img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/ce163a06-5544-433e-a09c-d38d78b0d3df" alt= "Animated GIF"              width="200" height="450">
</p>

#### Notifications
<img src="https://github.com/christianp-622/ScreenBreak/assets/74067404/cdab27bd-2fe9-4248-9e39-a536ce1899df" alt= "Animated GIF"
    width="200" height="450">

## Acknowledgment
Special thanks to:
DesignCode Youtube for the 3-hour tutorial with Rive Animations, custom fonts, as well as a provided 
codebase - https://www.youtube.com/watch?v=h4vyOz4Tztg&t=2878s

## Roadmap
For future iterations of this project, we want to implement a couple of things:
- Refactor to conform solely to MVVM architecture
- Implement Unit tests for various modules
