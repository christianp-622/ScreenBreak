//
//  AppDeviceActivity.swift
//  ReportExtension
//
//  Created by Christian Pichardo on 3/26/23.
//

import Foundation
import SwiftUI

struct ActivityReport {
    let totalDuration: TimeInterval
    let totalPickupsWithoutApplicationActivity: Int
    let longestActivity: DateInterval?
    let firstPickup: Date?
    let categories: [String]
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: String
    var numberOfPickups: Int
    var category: String
    var numberOfNotifs: Int
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d",hours,minutes)
    }
}
