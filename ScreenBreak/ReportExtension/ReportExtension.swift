//
//  ReportExtension.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import DeviceActivity
import SwiftUI

@main
struct ReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalCategoryAndAppReport {categoryReport in
            CategoryChartView(categoryReport: categoryReport)
        }
        TopAppsReport {topThreeReport in
            TopThreeView(topThreeReport: topThreeReport)
        }
        TotalActivityReport { totalActivity in
            TotalActivityView(activityReport: totalActivity)
        }
        

    }
}
