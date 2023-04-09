//
//  TotalCategoryReport.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import DeviceActivity
import SwiftUICharts


struct TotalCategoryAndAppReport: DeviceActivityReportScene {

    let context: DeviceActivityReport.Context = .totalCategory
    let content: (CategoryReport) -> CategoryChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> CategoryReport {

        var list: [CategoryDeviceActivity] = []
        var preData:[(String,Double)] = []
        var appPreData: [(String,Double)] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    let category = c.category
                    let hash = c.hashValue
                    let duration = c.totalActivityDuration
                    let categoryActivity = CategoryDeviceActivity(id: hash, category: category.localizedDisplayName!, duration: duration, token: category.token!)
                    list.append(categoryActivity)
                    
                    for await ap in c.applications{
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        if appName == bundle{
                            continue
                        }
                        let durationInMins = Double(ap.totalActivityDuration/60)
                        if durationInMins > 2.0 {
                            appPreData.append((appName, durationInMins))
                        }
                       
                    }
                   
                }
            }
        }
        
        list.sort(by: sortCategories)
        for cat in list {
            let durationInMins = Double(cat.duration/60)
            if durationInMins > 2.0 {
                preData.append((cat.category, durationInMins))
            }
        }
        
        
        return CategoryReport(totalDuration: totalActivityDuration, categories: list, chartData: preData, appChartData:appPreData)
    }
    
}

func sortCategories(this:CategoryDeviceActivity, that:CategoryDeviceActivity) -> Bool {
  return this.duration > that.duration
}


