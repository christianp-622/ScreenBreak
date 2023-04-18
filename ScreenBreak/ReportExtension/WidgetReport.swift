//
//  WidgetReport.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 4/11/23.
//

import Foundation
import SwiftUI
import DeviceActivity

struct WidgetReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .widget
    
    // Define the custom configuration and the resulting view for this report.
    let content: (TotalActivityWidgetReport) -> WidgetReportView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> TotalActivityWidgetReport {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
       
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        return TotalActivityWidgetReport(totalDuration:totalActivityDuration)
    }
    
}
