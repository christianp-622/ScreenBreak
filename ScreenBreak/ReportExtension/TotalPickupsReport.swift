//
//  TotalPickupsReport.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 4/14/23.
//

import DeviceActivity
import SwiftUI
import SwiftUICharts

struct TotalPickupsReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .moreInsights
    
    // Define the custom configuration and the resulting view for this report.
    let content: (MoreInsightsReport) -> PickupsChartView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> MoreInsightsReport {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        var appList: [AppDeviceActivity] = []
        var catsList: [CategoryDeviceActivity] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        var totalPickupsWithout = 0
        var longestActivity:DateInterval?
        var firstPickup:Date?
        var categories:[String] = []
       
        for await d in data {
            for await a in d.activitySegments{
                totalPickupsWithout = a.totalPickupsWithoutApplicationActivity
                // This will give us the day you used the device the most, but we need to set the filter beyond
                // a day otherwise it will be nil
                longestActivity = a.longestActivity
                firstPickup = a.firstPickup
             
                for await c in a.categories {
                    let category = c.category
                    let hash = c.hashValue
                    let duration = c.totalActivityDuration
                    let categoryActivity = CategoryDeviceActivity(id: hash, category: category.localizedDisplayName!, duration: duration, token: category.token!)
                    catsList.append(categoryActivity)
                    categories.append((c.category.localizedDisplayName)!)
                    
                    for await ap in c.applications {
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        if appName == bundle{
                            continue
                        }
                        
                        let duration = Int(ap.totalActivityDuration)
                        let durationInterval = ap.totalActivityDuration
                        let category = c.category.localizedDisplayName!
                        let token = ap.application.token!
                        let formatedDuration = formatDuration(duration: duration)
                        let numberOfPickups = ap.numberOfPickups
                        let notifs = ap.numberOfNotifications
                        
                        // Create stuct with all app information the api gives us
                        let app = AppDeviceActivity(id: bundle, token: token, displayName: appName, duration: formatedDuration, durationInterval: durationInterval, numberOfPickups: numberOfPickups,category: category, numberOfNotifs: notifs)
                        appList.append(app)
                    }
                }
            }
        }
        
        // Format date for chart
        let pChartData = makePickUpsCategoryChartData(appList: appList)
        let nChartData = makeNotifsCategoryChartData(appList: appList)
        let pAppChartData = makePickUpsAppChartData(appList:appList)
        let nAppChartData = makeNotifsAppChartData(appList: appList)
        
        // Gives us an understandable string representation of first pickup
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let dateString = formatter.string(from: firstPickup!)
        
        let formatter2 = DateComponentsFormatter()
        formatter2.allowedUnits = [.hour, .minute, .second]
        formatter2.unitsStyle = .full
       
        return MoreInsightsReport(apps: appList,
                                  categories: catsList,
                                  firstPickup: dateString,
                                  totalPickupsWithoutApplicationActivity: totalPickupsWithout,
                                  longestActivity: formatter2.string(for: longestActivity),
                                  pickupsChartData: pChartData,
                                  notifsChartData: nChartData,
                                  pickupsAppChartData: pAppChartData,
                                  notifsAppChartData:nAppChartData)
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
    
    func makePickUpsCategoryChartData(appList: [AppDeviceActivity]) -> [(String, Double)] {
        let categoriesWithPickups = appList.reduce(into: [(String, Double)]()) { result, element in
            let category = element.category
            let pickups = element.numberOfPickups
            
            if let index = result.firstIndex(where: { $0.0 == category }) {
                result[index].1 += Double(pickups)
            } else {
                if pickups > 0 {
                    result.append((category, Double(pickups)))
                }
            }
        }
        
        return categoriesWithPickups
    }
    
    func makePickUpsAppChartData(appList: [AppDeviceActivity]) -> [(String, Double)] {
        let appsWithPickups = appList.reduce(into: [(String, Double)]()) { result, element in
            let app = element.displayName
            let pickups = element.numberOfPickups
            
            if pickups > 0{
                result.append((app, Double(pickups)))
            }
            
        }
        return appsWithPickups
    }
    func makeNotifsAppChartData(appList: [AppDeviceActivity]) -> [(String, Double)] {
        let appsWithNotifs = appList.reduce(into: [(String, Double)]()) { result, element in
            let app = element.displayName
            let notifs = element.numberOfNotifs
            if notifs > 0 {
                result.append((app, Double(notifs)))
            }
        }
        
        return appsWithNotifs
    }
    
    func makeNotifsCategoryChartData(appList: [AppDeviceActivity]) -> [(String, Double)] {
        let categoriesWithNotifs = appList.reduce(into: [(String, Double)]()) { result, element in
            let category = element.category
            let notifs = element.numberOfNotifs
            
            if let index = result.firstIndex(where: { $0.0 == category }) {
                result[index].1 += Double(notifs)
            } else {
                if notifs > 0{
                    result.append((category, Double(notifs)))
                }
            }
        }
        
        return categoriesWithNotifs
    }
}
