//
//  TotalPickupsReport.swift
//  ReportExtension
//
//  Created by Moe Ghanem on 4/11/23.
//

import DeviceActivity
import SwiftUI
import SwiftUICharts

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let moreInsights = Self("More Insights")
}

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
                        appList.append(app)
                    }
                }
            }
        }
        
        let pChartData = ChartData(values: makePickUpsCharData(appList: <#T##[AppDeviceActivity]#>))
        let nChartData = ChartData(values: makeNotifsChartData(appList: <#T##[AppDeviceActivity]#>))
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let formatter2 = DateComponentsFormatter()
        formatter2.allowedUnits = [.hour, .minute, .second]
        formatter2.unitsStyle = .full
        return MoreInsightsReport(apps: appList,
                                  categories: catsList,
                                  firstPickup: formatter.string(for: firstPickup),
                                  totalPickupsWithoutApplicationActivity: totalPickupsWithout,
                                  longestActivity: formatter2.string(for: longestActivity),
                                  pickupsChartData: pChartData,
                                  notifsChartData: nChartData)
    }
    
    func makePickUpsCharData(appList: [AppDeviceActivity]) -> [(String, Int)] {
        let categoriesWithPickups = appList.reduce(into: [(String, Int)]()) { result, element in
            let category = element.category
            let pickups = element.numberOfPickups
            
            if let index = result.firstIndex(where: { $0.0 == category }) {
                result[index].1 += pickups
            } else {
                result.append((category, pickups))
            }
        }
        
        return categoriesWithPickups
    }
    func makeNotifsChartData(appList: [AppDeviceActivity]) -> [(String, Int)] {
        let categoriesWithNotifs = appList.reduce(into: [(String, Int)]()) { result, element in
            let category = element.category
            let notifs = element.numberOfNotifs
            
            if let index = result.firstIndex(where: { $0.0 == category }) {
                result[index].1 += notifs
            } else {
                result.append((category, notifs))
            }
        }
        
        return categoriesWithNotifs
    }
}


