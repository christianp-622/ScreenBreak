//
//  TotalCategoryReport.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import DeviceActivity


struct TotalCategoryReport: DeviceActivityReportScene {

    let context: DeviceActivityReport.Context = .totalCategory
    let content: (CategoryReport) -> CategoryChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> CategoryReport {

        var list: [CategoryDeviceActivity] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    let category = c.category
                    let hash = c.hashValue
                    let duration = c.totalActivityDuration
                    let categoryActivity = CategoryDeviceActivity(id: hash, category: category.localizedDisplayName!, duration: duration)
                    list.append(categoryActivity)
                }
            }
        }
        
        list.sort(by: sortCategories)
        
        return CategoryReport(totalDuration: totalActivityDuration, categories: list)
    }
    
}

func sortCategories(this:CategoryDeviceActivity, that:CategoryDeviceActivity) -> Bool {
  return this.duration > that.duration
}

