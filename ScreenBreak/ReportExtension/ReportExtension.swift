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
        HomeReport {chartAndTopThreeReport in
            HomeReportView(homeReport: chartAndTopThreeReport)
        }
        
        TopAppsReport {topThreeReport in
            TopThreeView(topThreeReport: topThreeReport)
        }
        
        TotalActivityReport { totalActivity in
            TotalActivityView(activityReport: totalActivity)
        }
        
        WidgetReport{ report in
            WidgetReportView(widgetReport: report)
        }
        
        TotalPickupsReport { moreInsightsReport in
            PickupsChartView(moreInsightsReport: moreInsightsReport)
        }
       
        

    }
    
   
}
