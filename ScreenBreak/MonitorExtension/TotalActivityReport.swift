//
//  TotalActivityReport.swift
//  MonitorExtension
//
//  Created by Christian Pichardo on 3/23/23.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (ActivityReport) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        var res = ""
        var list: [AppDeviceActivity] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        var totalPickups = 0
        var longestActivity:DateInterval?
        var firstPickup:Date?
        var categories:[String] = []
        print("HERERERERE")
        for await d in data {
            res += d.user.appleID!.debugDescription
            res += d.lastUpdatedDate.description
            for await a in d.activitySegments{
                res += a.totalActivityDuration.formatted()
                totalPickups = a.totalPickupsWithoutApplicationActivity
                longestActivity = a.longestActivity
                firstPickup = a.firstPickup
                
                
                for await c in a.categories {
                    categories.append((c.category.localizedDisplayName)!)
                    for await ap in c.applications {
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        let duration = Int(ap.totalActivityDuration)
                        let category = c.category.localizedDisplayName!
                        
                        let numberOfHours = duration / 3600
                        let numberOfMins = (duration % 3600) / 60
                        var formatedDuration = ""
                        if numberOfHours == 0 {
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfMins)mins"
                            }else{
                                formatedDuration = "\(numberOfMins)min"
                            }
                        }else if numberOfHours == 1{
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfHours)hr \(numberOfMins)mins"
                            }else{
                                formatedDuration = "\(numberOfHours)hr \(numberOfMins)min"
                            }
                        }else{
                            if numberOfMins != 1{
                                formatedDuration = "\(numberOfHours)hrs \(numberOfMins)mins"
                            }else{
                                formatedDuration = "\(numberOfHours)hrs \(numberOfMins)min"
                            }
                        }
                       
                        let numberOfPickups = ap.numberOfPickups
                        let notifs = ap.numberOfNotifications
                        let app = AppDeviceActivity(id: bundle, displayName: appName, duration: formatedDuration, numberOfPickups: numberOfPickups,category: category, numberOfNotifs: notifs)
                        list.append(app)
                    }
                }
            }
        }
        
        return ActivityReport(totalDuration: totalActivityDuration,totalPickupsWithoutApplicationActivity: totalPickups, longestActivity: longestActivity, firstPickup: firstPickup, categories: categories, apps: list)
    }
}
