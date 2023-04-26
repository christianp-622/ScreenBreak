//
//  AppDeviceActivity.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import Foundation
import SwiftUI
import DeviceActivity
import ManagedSettings
import SwiftUICharts

struct ActivityReport {
    let totalDuration: TimeInterval
    let totalPickupsWithoutApplicationActivity: Int
    let longestActivity: DateInterval?
    let firstPickup: Date?
    let categories: [String]
    let apps: [AppDeviceActivity]
}

struct TotalActivityWidgetReport{
    let totalDuration: TimeInterval
}

struct MoreInsightsReport{
    var apps: [AppDeviceActivity]
    var categories: [CategoryDeviceActivity]
    var firstPickup: String
    var totalPickupsWithoutApplicationActivity: Int
    var longestActivity: String?
    var pickupsChartData: [(String, Double)]
    var notifsChartData: [(String, Double)]
    var pickupsAppChartData: [(String, Double)]
    var notifsAppChartData: [(String, Double)]
}

struct TopThreeReport {
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var token: ApplicationToken
    var displayName: String
    var duration: String
    var durationInterval: TimeInterval
    var numberOfPickups: Int
    var category: String
    var numberOfNotifs: Int
}

struct ChartAndTopThreeReport{
    var totalDuration:TimeInterval
    var categoryChartData: [(String, Double)]
    var appChartData: [(String, Double)]
    var topApps: [AppDeviceActivity]
}

struct CategoryDeviceActivity: Identifiable {
    var id:Int
    var category:String
    var duration: TimeInterval
    var token: ActivityCategoryToken
}


extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d",hours,minutes)
    }
    
    func stringFromTimeIntervalChartLabel() -> String {
            let time = NSInteger(self)
            let minutes = (time / 60) % 60
            let hours = (time / 3600)
            if(hours == 0){
                 return String(format: " %0.2dh ",minutes)
        }
            return String(format: " %0.2dh %0.2dm ",hours,minutes)
    }
    
    func formatedDuration() -> String{
        let duration = NSInteger(self)
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
    
    func durationInHours() -> Double{
        let duration = NSInteger(self)
        let numberOfHours = duration / 3600
        return Double(numberOfHours)
        
    }
    
    
}
