//
//  MySchedule.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/27/23.
//

import Foundation
import DeviceActivity
import UserNotifications

// The Device Activity name is how I can reference the activity from within my extension
extension DeviceActivityName {
    // Set the name of the activity to "daily"
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    // Set the name of the event to "discouraged"
    static let discouraged = Self("discouraged")
}


class MySchedule {
    static public func setSchedule(endHour: Int, endMins:Int) {
        print("Setting schedule...")
        print(("Hour is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!))
        let hourComponents = Calendar.current.dateComponents([.hour], from: Date())
        let curHour = hourComponents.hour ?? 0
        
        let minuteComponents = Calendar.current.dateComponents([.minute], from: Date())
        let curMins = minuteComponents.minute ?? 0
        
        var nextMin = curMins + 2
        
        let notifCenter = UNUserNotificationCenter.current()
        
        let startTrigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: curHour, minute: nextMin), repeats: false)
        let startContent = UNMutableNotificationContent()
        startContent.title = "Screen Break"
        startContent.body = "You've entered Restriction Mode! Good Luck!"
        startContent.categoryIdentifier = "customIdentifier"
        startContent.userInfo = ["customData": "fizzbuzz"]
        startContent.sound = UNNotificationSound.default
        let startRequest = UNNotificationRequest(identifier: UUID().uuidString, content: startContent, trigger: startTrigger)
        notifCenter.add(startRequest)
        
        
        //Setting Notifications
        
        // Will try this out later
        /*let center = UNUserNotificationCenter.current()
        let halfTrigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: endHour, minute: endMins), repeats: true)
        let halfContent = UNMutableNotificationContent()
        halfContent.title = "Screen Break - Restriction Mode"
        halfContent.body = "You're halfway done with Restriction Mode. You've got this!"
        halfContent.categoryIdentifier = "customIdentifier"
        halfContent.userInfo = ["customData": "fizzbuzz"]
        halfContent.sound = UNNotificationSound.default
        let halfRequest = UNNotificationRequest(identifier: UUID().uuidString, content: halfContent, trigger: halfTrigger)
        notifCenter.add(halfRequest)*/
        
        let endTrigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: endHour, minute: endMins), repeats: false)
        let endContent = UNMutableNotificationContent()
        endContent.title = "Screen Break"
        endContent.body = "Congrats! You've reached the end of Restriction Mode"
        endContent.categoryIdentifier = "customIdentifier"
        endContent.userInfo = ["customData": "fizzbuzz"]
        endContent.sound = UNNotificationSound.default
        let endRequest = UNNotificationRequest(identifier: UUID().uuidString, content: endContent, trigger: endTrigger)
        notifCenter.add(endRequest)
        
        print("END TIME: \(endHour):\(endMins)")
        
        MyModel.shared.setShieldRestrictions()
        
        
        let schedule = DeviceActivitySchedule(
            // I've set my schedule to start and end at midnight
            // perhaps change this
            intervalStart: DateComponents(hour: curHour, minute: curMins),
            intervalEnd: DateComponents(hour: endHour, minute: endMins),
            // I've also set the schedule to repeat
            repeats: false
        )


        
        // Threshold doesnt really matter for right now?
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .discouraged: DeviceActivityEvent(
                applications: MyModel.shared.selectionToDiscourage.applicationTokens,
                threshold: DateComponents(second: 15)
            )
        ]
        
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.daily, during: schedule, events: events)
        } catch {
            print("Error monitoring schedule: ", error)
        }
    }
}

// Another ingredient to shielding apps is figuring out what the guardian wants to discourage
// The Family Controls framework has a SwiftUI element for this: the family activity picker

