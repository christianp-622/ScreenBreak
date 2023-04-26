//
//  HomeReport.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/28/23.
//

import SwiftUI
import DeviceActivity
import SwiftUICharts


struct HomeReport: DeviceActivityReportScene {

    let context: DeviceActivityReport.Context = .home
    let content: (ChartAndTopThreeReport) -> HomeReportView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ChartAndTopThreeReport {

        // Retrive data from each app and category
        var categoryList: [CategoryDeviceActivity] = []
        var appList: [AppDeviceActivity] = []
        
        // Format the data so we can display it in charts
        var categoryChartData:[(String,Double)] = []
        var appChartData: [(String,Double)] = []
        
       
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        
        
        for await d in data {
            for await a in d.activitySegments{
                for await c in a.categories {
                    let category = c.category
                    let hash = c.hashValue
                    let catDurationInMins = c.totalActivityDuration/60
                    
                    if catDurationInMins > 2.0{
                        categoryChartData.append((category.localizedDisplayName!, catDurationInMins))
                    }
                    
//                    let categoryActivity = CategoryDeviceActivity(id: hash, category: category.localizedDisplayName!, duration: duration, token: category.token!)
//
//                    categoryList.append(categoryActivity)
                    
                    for await ap in c.applications{
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        if appName == bundle{
                            continue
                        }
                        
                        let durationInMins = Double(ap.totalActivityDuration/60)
                        if durationInMins > 2.0 {
                            appChartData.append((appName, durationInMins))
                        }
                        
                        let duration = Int(ap.totalActivityDuration)
                        let durationInterval = ap.totalActivityDuration
                        let category = c.category.localizedDisplayName!
                        let token = ap.application.token!
                        
                        let formatedDuration = formatDuration(duration:duration)
                       
                        let numberOfPickups = ap.numberOfPickups
                        let notifs = ap.numberOfNotifications
                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval, numberOfPickups: numberOfPickups,category: category, numberOfNotifs: notifs)
                        appList.append(app)
                       
                    }
                   
                }
            }
        }
        
        appList.sort(by:sortApps)
        
        
        return ChartAndTopThreeReport(totalDuration: totalActivityDuration, categoryChartData: categoryChartData, appChartData:appChartData, topApps: [appList[0], appList[1], appList[2]])
    }
    
}

func formatDuration(duration:Int) -> String{
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
    return formatedDuration
}

func sortCategories(this:CategoryDeviceActivity, that:CategoryDeviceActivity) -> Bool {
  return this.duration > that.duration
}

func sortApps(this:AppDeviceActivity, that:AppDeviceActivity) -> Bool {
    return this.durationInterval > that.durationInterval
}


