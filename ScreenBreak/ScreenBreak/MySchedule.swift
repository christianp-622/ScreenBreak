//
//  MySchedule.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/27/23.
//

import Foundation
import DeviceActivity

// The Device Activity name is how I can reference the activity from within my extension
extension DeviceActivityName {
    // Set the name of the activity to "daily"
    static let daily = Self("daily")
}


extension DeviceActivityEvent.Name {
    // Set the name of the event to "encouraged"
    static let encouraged = Self("encouraged")
}

// The Schedule represents the time that will the extension will monitor for activity
let schedule = DeviceActivitySchedule(
    // I've set my schedule to start and end at midnight
    // perhaps change this
    intervalStart: DateComponents(hour: 0, minute: 0),
    intervalEnd: DateComponents(hour: 11, minute: 17),
    // I've also set the schedule to repeat
    repeats: true
)

class MySchedule {
    static public func setSchedule() {
        print("Setting schedule...")
        print("Hour is: ", Calendar.current.dateComponents([.hour, .minute], from: Date()).hour!)

        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .encouraged: DeviceActivityEvent(
                applications: MyModel.shared.selectionToEncourage.applicationTokens,
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

