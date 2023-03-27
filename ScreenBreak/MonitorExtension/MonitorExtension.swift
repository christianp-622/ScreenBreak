//
//  MonitorExtension.swift
//  MonitorExtension
//
//  Created by Christian Pichardo on 3/23/23.
//

import DeviceActivity
import SwiftUI

@main
struct MonitorExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            return TotalActivityView(activityReport: totalActivity)
        }
        // Add more reports here...
    }
}
