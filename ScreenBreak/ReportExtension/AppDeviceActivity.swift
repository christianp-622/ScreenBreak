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

struct ActivityReport {
    let totalDuration: TimeInterval
    let totalPickupsWithoutApplicationActivity: Int
    let longestActivity: DateInterval?
    let firstPickup: Date?
    let categories: [String]
    let apps: [AppDeviceActivity]
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

struct CategoryReport{
    var totalDuration:TimeInterval
    var categories: [CategoryDeviceActivity]
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
}
