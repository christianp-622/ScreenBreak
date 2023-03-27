//
//  TotalActivityView.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import SwiftUI

struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            Text("Total Screen Time")
            Spacer(minLength: 10)
            Text(activityReport.totalDuration.stringFromTimeInterval())
            Spacer(minLength: 10)
            //Text("First Pickup: \(activityReport.firstPickup?.description ?? "NIL")")
            Text("TotalPickupsWithoutApplicationActivity: \(activityReport.totalPickupsWithoutApplicationActivity)")
            Text("LongestActivity: \(activityReport.longestActivity?.description ?? "NIL")")
            Text("Categories: \(activityReport.categories.description)")
            Text("Name, numPickups, numNotifs, duration")
            List(activityReport.apps) { app in
                ListRow(eachApp: app)
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    var body: some View {
        HStack {
            Text(eachApp.displayName)
            //Spacer()
            //Text(eachApp.id)
            Spacer()
            Text("\(eachApp.numberOfPickups)")
            Spacer()
            Text("\(eachApp.numberOfNotifs)")
            Spacer()
            Text(String(eachApp.duration))
            Spacer()
            Text("\(eachApp.category)")
        }
    }
}

