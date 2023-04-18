//
//  TopAppsReport.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/2/23.
//

import SwiftUI
import DeviceActivity

struct TopAppsReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .home
    
    // Define the custom configuration and the resulting view for this report.
    let content: (TopThreeReport) -> TopThreeView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> TopThreeReport {
        // Reformat the data into a configuration that can be used 
        var list: [AppDeviceActivity] = []
        
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    for await ap in c.applications {
                        
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        let duration = Int(ap.totalActivityDuration)
                        let durationInterval = ap.totalActivityDuration
                        let category = c.category.localizedDisplayName!
                        let token = ap.application.token!
                        
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
                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval, numberOfPickups: numberOfPickups,category: category, numberOfNotifs: notifs)
                        list.append(app)
                    }
                }
            }
        }
        list.sort(by: sortApps)
        if list.count < 3{
            if list.count == 2{
                
            }
            if list.count == 1{
                
            }
            if list.count == 0{
                
            }
        }
        return TopThreeReport(apps: [list[0], list[1], list[2]])
    }
}







