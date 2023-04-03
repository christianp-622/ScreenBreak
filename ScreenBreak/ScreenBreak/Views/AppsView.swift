//
//  AppsView.swift
//  ScreenBreak
//
//  Created by Christian Pichardo on 3/7/23.
//

import SwiftUI
import DeviceActivity
import RiveRuntime

struct AppsView: View {
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    //@State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Category")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )
    var body: some View {
        NavigationView {
            DeviceActivityReport(context, filter: filter)
        }
        .navigationViewStyle(.stack)
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}
